package Net::GPSD3::Return::Unknown;
use strict;
use warnings;
use base qw{Net::GPSD3::Base};

our $VERSION='0.03';

=head1 NAME

Net::GPSD3::Return::Unknown - Net::GPSD3 Return Base Class

=head1 SYNOPSIS

  use base qw{Net::GPSD3::Return::Unknown};

=head1 DESCRIPTION

=head1 CONSTRUCTOR

=head2 new

=head1 METHODS

=head2 parent

Returns the parent Net::GPSD3 object

=cut

sub parent {shift->{"parent"}};

=head2 class

Returns the class string for the particular JSON message.  Classes in all upper case are from gpsd.  Classes with initial capital letter are from this Perl package.  Class in all lower case are currently reserved.  Private extension classes should use camel case.

=cut

sub class {shift->{"class"}};

=head2 string

This is the JSON string as passed over the TCP connection.

=cut

sub string {shift->{"string"}};

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
