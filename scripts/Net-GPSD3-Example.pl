#!/usr/bin/perl
use strict;
use warnings;
$|=1;

=head1 NAME

Net-GPSD3-Example.pl - Net::GPSD3 Example

=cut

use Net::GPSD3;
my $gpsd=Net::GPSD3->new; #default host port
$gpsd->watch;             #default handler
