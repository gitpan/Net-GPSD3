#!/usr/bin/perl
use strict;
use warnings;
use Net::GPSD3;
use Data::Dumper qw{Dumper};
$|=1;

=head1 NAME

perl-Net-GPSD3-poll.pl - Net::GPSD3 Poll Example

=cut

my $host=shift || undef;
my $port=shift || undef;

my $gpsd=Net::GPSD3->new(host=>$host, port=>$port); #default host port as undef

my $obj=$gpsd->poll;
print $obj->timestamp, "\n";
print Dumper($gpsd->poll);
