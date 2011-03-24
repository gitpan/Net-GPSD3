package Net::GPSD3::Return::POLL;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown::Timestamp};

our $VERSION='0.12';

=head1 NAME

Net::GPSD3::Return::POLL - Net::GPSD3 Return POLL Object

=head1 SYNOPSIS

=head1 DESCRIPTION

Provides a Perl object interface to the POLL object returned by the GPSD daemon.

=head1 METHODS

=head2 class

Returns the object class

=head2 string

Returns the JSON string

=head2 parent

Return the parent Net::GPSD object

=head2 time

=head2 timestamp

=head2 datetime

=head2 active

=cut

sub active {shift->{"active"}};

=head2 fixes

=cut

sub fixes {
  my $self=shift;
  $self->{"fixes"}=[] unless ref($self->{"fixes"}) eq "ARRAY";
  return wantarray ? @{$self->{"fixes"}} : $self->{"fixes"};
}

=head2 Fixes

=cut

sub Fixes {
  my $self=shift;
  $self->{"Fixes"}=[map {$self->parent->constructor(%$_, string=>$self->parent->encode($_))} $self->fixes]
    unless defined $self->{"Fixes"};
  return $self->{"Fixes"};
}

=head2 gst

=cut

sub gst {
  my $self=shift;
  $self->{"gst"}=[] unless ref($self->{"gst"}) eq "ARRAY";
  return wantarray ? @{$self->{"gst"}} : $self->{"gst"};
}

=head2 Gst

=cut

sub Gst {
  my $self=shift;
  $self->{"Gst"}=[map {$self->parent->constructor(%$_, string=>$self->parent->encode($_))} $self->gst]
    unless defined $self->{"Gst"};
  return $self->{"Gst"};
}

=head2 skyviews

=cut

sub skyviews {
  my $self=shift;
  $self->{"skyviews"}=[] unless ref($self->{"skyviews"}) eq "ARRAY";
  return wantarray ? @{$self->{"skyviews"}} : $self->{"skyviews"};
}

=head2 Skyviews

=cut

sub Skyviews {
  my $self=shift;
  $self->{"Skyviews"}=[map {$self->parent->constructor(%$_, string=>$self->parent->encode($_))} $self->skyviews]
    unless defined $self->{"Skyviews"};
  return $self->{"Skyviews"};
}

=head1 BUGS

DavisNetworks.com supports all Perl applications including this package.

Log on RT and send to gpsd-dev email list

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

The full text of the license can be found in the LICENSE file included with this module.

=head1 SEE ALSO

L<Net::GPSD3>, L<Net::GPSD3::Return::Unknown::Timestamp>

=cut

1;
