package Net::GPSD3::POE;
use strict;
use warnings;
use base qw{Net::GPSD3};
use POE::Session;
use POE::Wheel::ReadWrite;
use POE::Filter::Line;

our $VERSION='0.15';

=head1 NAME

Net::GPSD3::POE - Net::GPSD3 POE Session object

=head1 SYNOPSIS

  use POE;
  use Net::GPSD3::POE;
  my $gpsd=Net::GPSD3::POE->new;
  #$gpsd->addHandler;
  $gpsd->session;
  #other POE::Sessions...
  POE::Kernel->run;

One Liner

  perl -MPOE -MNet::GPSD3::POE -e 'Net::GPSD3::POE->new->session;POE::Kernel->run;'

=head1 DESCRIPTION

This package adds a L<POE::Session> capabilty to Net::GPSD3.

=head1 METHODS

=head2 session

Configures and returns a POE::Session object

=cut

sub session {
  my $self=shift; #ISA Net::GPSD::POE
  return POE::Session->create(
    inline_states => {
      _start      => sub {
                           my $heap=$_[HEAP];
                           $heap->{"wheel"}=POE::Wheel::ReadWrite->new(
                             Handle => $self->socket,
                             Filter => POE::Filter::Line->new(
                                         InputLiteral  => "\r\n",
                                         OutputLiteral => "\n",
                             ),
                             InputEvent => "got_event",
                           );
                           $heap->{"wheel"}->put(qq(?WATCH={"enable":true,"json":true};));
                           $heap->{"gpsd"}=$self;
                         },
      got_event   => \&_event_handler,
    },
  );
}

sub _event_handler {
  my ($heap, $line)=@_[HEAP, ARG0];
  my $self=$heap->{"gpsd"}; #ISA NET::GPSD::POE;
  my @handler=$self->handlers;
  push @handler, \&Net::GPSD3::default_handler unless scalar(@handler);
  my $object=$self->constructor($self->decode($line), string=>$line);
  foreach my $handler (@handler) {
    &{$handler}($object);
  }
  $self->cache($object);
  return $self;
}

=head1 BUGS

Log on RT and Send to gpsd-dev email list

=head1 SUPPORT

DavisNetworks.com supports all Perl applications including this package.

Try gpsd-dev email list

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  STOP, LLC
  domain=>michaelrdavis,tld=>com,account=>perl
  http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

  The BSD License

The full text of the license can be found in the LICENSE file included with this module.

=head1 SEE ALSO

L<Net::GPSD3>, L<POE>, L<POE::Session>, L<POE::Wheel::ReadWrite>, L<POE::Filter::Line>

=cut

1;
