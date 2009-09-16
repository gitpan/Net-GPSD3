package Net::GPSD3::Return::SKY;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown};
use UNIVERSAL;

our $VERSION='0.01';

=head1 NAME

Net::GPSD3::Return::VERSION - Net::GPSD3 Return Version Object

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
  my @data=grep {$_->{"used"}} $self->satellites;
  return scalar(@data);
}

=head2 satellites

  my $satellites=$object->satellites(); #[{},...]
  my @satellites=$object->satellites(); #({},...)
  my $satellites=$object->satellites(1); #[bless{},...]
  my @satellites=$object->satellites(1); #(bless{},...)

=cut

sub satellites {
  my $self=shift;
  my $flag=shift||0;
  my $data=$self->{"satellites"};
  $data=[] unless ref($data) eq "ARRAY";
  if ($flag) {
    my $class="Net::GPSD3::Return::Satellite";
    $data=[map {$class->new(class  => "Satellite",
                            parent => $self->parent,
                            string => "", #Is this worth building this?
                            %$_)} grep {ref($_) eq "HASH"} @$data];
    
  }
  return wantarray ? @$data : $data;
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
