package Net::GPSD3::Return::GST;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown::Timestamp};

our $VERSION='0.13';

=head1 NAME

Net::GPSD3::Return::GST - Net::GPSD3 Return GST Object

=head1 SYNOPSIS

=head1 DESCRIPTION

Provides a Perl object interface to the GST object returned by the GPSD daemon.

  {
    'class' => 'GST',
    'device' => '/dev/cuaU0',
    'tag' => '0x0130',
    'time' => '1970-01-01T00:00:00.00Z',
    'lat' => '0',
    'lon' => '0',
    'alt' => '0.002',
    'rms' => '0',
    'orient' => '0',
    'major' => '0'
    'minor' => '-0',
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

=head2 timestamp

=head2 datetime

=head2 lat

=cut

sub lat {shift->{"lat"}};

=head2 lon

=cut

sub lon {shift->{"lon"}};

=head2 alt

=cut

sub alt {shift->{"alt"}};

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

L<Net::GPSD3>, L<Net::GPSD3::Return::Unknown::Timestamp>

=cut

1;
