package Net::GPSD3::Return::VERSION;
use strict;
use warnings;
use base qw{Net::GPSD3::Return::Unknown};

our $VERSION='0.03';

=head1 NAME

Net::GPSD3::Return::VERSION - Net::GPSD3 Return VERSION Object

=head1 SYNOPSIS

=head1 DESCRIPTION

Provides a Perl object interface to the VERSION object returned by the GPSD daemon.

=head1 METHODS

=head2 class

Returns the object class

=head2 string

Returns the JSON string

=head2 parent

Return the parent Net::GPSD object

=head2 release

=cut

sub release {shift->{"release"}};

=head2 rev

=cut

sub rev {shift->{"rev"}};

=head2 api_major

=cut

sub api_major {shift->{"api_major"}};

=head2 api_minor

=cut

sub api_minor {shift->{"api_minor"}};

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
