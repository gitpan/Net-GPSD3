package Net::GPSD3;
use strict;
use warnings;
use base qw{Net::GPSD3::Base};
use IO::Socket::INET qw{};
use JSON::XS qw{};

our $VERSION='0.02';

=head1 NAME

Net::GPSD3 - Interface to the gpsd server daemon API Version 3 (JSON).

=head1 SYNOPSIS

  use Net::GPSD3;
  my $gpsd=Net::GPSD3->new(host=>"127.0.0.1", port=>2947); #defaults
  $gpsd->addHandler(\&myHandler);
  $gpsd->watch;  

  sub myHandler {
    my $object=shift;
    use Data::Dumper qw{Dumper};
    print Dumper($object);
  }

=head1 DESCRIPTION

=head1 CONSTRUCTOR

=head2 new

Returns a new Net::GPSD3 object.

  my $gpsd=Net::GPSD3->new;
  my $gpsd=Net::GPSD3->new(host=>"127.0.0.1", port=>2947); #defaults

=head1 METHODS

=cut

sub initialize {
  my $self=shift;
  %$self=@_;
  $self->host('127.0.0.1') unless $self->host;
  $self->port(2947)        unless $self->port;
}

=head2 host

Sets or returns the current gpsd host.

 my $host=$obj->host;

=cut

sub host {
  my $self=shift;
  if (@_) {
    $self->{'host'}=shift;
    undef($self->{'sock'});
  }
  return $self->{'host'};
}

=head2 port

Sets or returns the current gpsd TCP port.

 my $port=$obj->port;

=cut

sub port {
  my $self=shift;
  if (@_) {
    $self->{'port'}=shift;
    undef($self->{'sock'});
  }
  return $self->{'port'};
}

=head2 sock

  my $sock=$gpsd->sock;  #try to reconnect on failure

=cut

sub sock {
  my $self=shift;
  unless (defined($self->{"sock"}) and defined($self->{'sock'}->connected)) { 
    $self->{"sock"}=IO::Socket::INET->new(PeerAddr=>$self->host,
                                          PeerPort=>$self->port);
  }
  return $self->{'sock'};
}

=head2 watch

  $gpsd->watch;  #will not return unless something goes wrong.

=cut

sub watch {
  my $self=shift;
  my @handler=$self->handlers;
  push @handler, \&default_handler unless scalar(@handler);
  $self->sock->send(qq(?WATCH={"enable":true};\n));
  my $object;
  local $/="\r\n";
  while (defined($_=$self->sock->getline)) {
    chomp;
    my $json=JSON::XS->new;
    my $data=$json->decode($_);
    my $object=$self->return(%$data, string=>$_);
    #my $object=$data;
    foreach my $handler (@handler) {
      &{$handler}($object);
    }
  }
  return $self;
}

=head2 handlers

  my @handler=$gpsd->handlers; #()
  my $handler=$gpsd->handlers; #[]

=cut

sub handlers {
  my $self=shift;
  $self->{'handler'}=[] unless ref($self->{'handler'});
  return wantarray ? @{$self->{'handler'}} : $self->{'handler'};
}

=head2 addHandler

  $gpsd->addHandler(\&myHandler);
  $gpsd->addHandler(\&myHandler1, \&myHandler2);

=cut

sub addHandler {
  my $self=shift;
  my $array=$self->handlers;
  push @$array, @_ if @_;
  return $self;
}

=head2 default_handler

=cut

sub default_handler {
  my $object=shift;
  if ($object->class eq "TPV") {
    printf "%s, Time: %s, Lat: %s, Lon: %s, Speed: %s, Heading: %s\n",
            $object->class || '',
            $object->time || '',
            $object->lat || '',
            $object->lon || '',
            $object->speed || '',
            $object->track || '';
  } elsif ($object->class eq "SKY") {
    printf "%s, Time: %s, Satellites: %s, Used: %s, PRNs: %s\n",
            $object->class || '',
            $object->time || '',
            $object->reported || '',
            $object->used || '',
            join(",", map {$_->{"PRN"}} grep {$_->{"used"}} $object->satellites),
  } elsif ($object->class eq "VERSION") {
    printf "%s, Release: %s\n", $object->class, $object->release;
  } else {
    printf "%s, Enabled: %s\n", $object->class || '', $object->enable ? 1 : 0;
    #use Data::Dumper;
    #print Dumper($object);
  }
}

sub return {
  my $self=shift;
  my %data=@_;
  my $class=join("::", ref($self), "Return", $data{"class"});
  eval("use $class");
  if ($@) { #Failed to load class
    my $unknown=join("::", ref($self), "Return", "Unknown");
    eval("use $unknown");
    return $unknown->new(parent=>$self, %data);
  } else {
    return $class->new(parent=>$self, %data);
  }
}

=head1 BUGS

Log on RT and Send to gpsd-dev email list

=head1 SUPPORT

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

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<Net::GPSD>, L<GSP::Point>

=cut

1;
