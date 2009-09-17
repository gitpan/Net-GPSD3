package Net::GPSD3::Return::SKY;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown};
use Net::GPSD3::Return::Satellite;

our $VERSION='0.02';

=head1 NAME

Net::GPSD3::Return::SKY - Net::GPSD3 Return SKY Object

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS PROPERTIES

=head2 device

=cut

sub device {shift->{"device"}};

=head2 tag

=cut

sub tag {shift->{"tag"}};

=head2 time

=cut

sub time {shift->{"time"}};

=head2 reported

Count of satellites in view

=cut

sub reported {shift->{"reported"}};

=head2 used

Count of satellites used in calculation

=cut

sub used {
  my $self=shift;
  unless (defined($self->{"used"})) {
    my @data=grep {$_->{"used"}} $self->satellites;
    $self->{"used"}=scalar(@data);
  }
  return $self->{"used"};
}

=head2 satellites

  my $satellites=$sky->satellites(); #[{},...]
  my @satellites=$sky->satellites(); #({},...)

=cut

sub satellites {
  my $self=shift;
  unless (ref($self->{"satellites"}) eq "ARRAY") {
    $self->{"satellites"}=[];
  }
  return wantarray ? @{$self->{"satellites"}} : $self->{"satellites"};
}

=head2 satelliteObjects

  my @satellites=$sky->satelliteObjects; #(bless{},...)
  my $satellites=$sky->satelliteObjects; #[bless{},...]
  
=cut

sub satelliteObjects {
  my $self=shift;
  unless (defined($self->{"satelliteObjects"})) {
    $self->{"satelliteObjects"}=
          [map {Net::GPSD3::Return::Satellite->new(
                  class  => "Satellite",
                  parent => $self->parent,
                  string => "", #Is this worth building this?
                  %$_)} grep {ref($_) eq "HASH"} $self->satellites];
  }
  return $self->{"satelliteObjects"};
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

L<Net::GPSD3>

=cut

1;
