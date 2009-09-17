package Net::GPSD3::Return::Satellite;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown};

our $VERSION='0.02';

=head1 NAME

Net::GPSD3::Return::Satellite - Net::GPSD3 Return Object Satellite Class

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS PROPERTIES

=head2 PRN

=cut

sub PRN {shift->{"PRN"}};

=head2 used

=cut

sub used {shift->{"used"}};

=head2 az

=cut

sub az {shift->{"az"}};

=head2 el

=cut

sub el {shift->{"el"}};

=head2 ss

=cut

sub ss {shift->{"ss"}};

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
