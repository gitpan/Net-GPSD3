package Net::GPSD3::Return::SKY;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown};
use Net::GPSD3::Return::Satellite;

our $VERSION='0.03';

=head1 NAME

Net::GPSD3::Return::SKY - Net::GPSD3 Return SKY Object

=head1 SYNOPSIS

=head1 DESCRIPTION

Provides a Perl object interface to the SKY object returned by the GPSD daemon.

An example JSON object:

  {
    "class":"SKY",
    "tag":"MID4",
    "device":"/dev/ttyUSB0",
    "time":1253593665.430,
    "hdop":23.60,
    "reported":9,
    "satellites":
      [
        {"PRN":15,"el":77,"az":123,"ss":0, "used":false},
        {"PRN":18,"el":25,"az":268,"ss":0, "used":false},
        {"PRN":27,"el":13,"az":150,"ss":0, "used":false},
        {"PRN":29,"el":47,"az":228,"ss":0, "used":false},
        {"PRN":5, "el":39,"az":58, "ss":46,"used":true },
        {"PRN":21,"el":41,"az":309,"ss":33,"used":true },
        {"PRN":10,"el":32,"az":61, "ss":40,"used":true },
        {"PRN":8, "el":12,"az":48, "ss":40,"used":true },
        {"PRN":2, "el":9, "az":124,"ss":0, "used":false}
      ]
  }

=head1 METHODS PROPERTIES

=head2 class

Returns the object class

=head2 string

Returns the JSON string

=head2 parent

Return the parent Net::GPSD object

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

Returns a list of satellite data structures.

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

=head2 Satellites

Returns a list of L<Net::GPSD3::Return::Satellite> objects.

  my @satellites=$sky->Satellites; #(bless{},...)
  my $satellites=$sky->Satellites; #[bless{},...]
  
=cut

sub Satellites {
  my $self=shift;
  unless (defined($self->{"Satellites"})) {
    $self->{"Satellites"}=
          [map {Net::GPSD3::Return::Satellite->new(
                  class  => "Satellite",
                  parent => $self->parent,
                  string => $self->parent->encode($_),
                  %$_)} grep {ref($_) eq "HASH"} $self->satellites];
  }
  return wantarray ? @{$self->{"Satellites"}} : $self->{"Satellites"};
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
