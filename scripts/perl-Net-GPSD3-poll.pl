#!/usr/bin/perl
use strict;
use warnings;
use Net::GPSD3;
#use Data::Dumper qw{Dumper};

=head1 NAME

perl-Net-GPSD3-poll.pl - Net::GPSD3 Poll Example

=cut

my $host=shift || undef;
my $port=shift || undef;

my $gpsd=Net::GPSD3->new(host=>$host, port=>$port); #default host port as undef

my $poll=$gpsd->poll;

printf "Net::GPSD3:    %s\n", $poll->parent->VERSION;
printf "GPSD Release:  %s\n", $poll->parent->cache->VERSION->release;
printf "Protocol:      %s\n", $poll->parent->cache->VERSION->protocol;
printf "Sats Reported: %s\n", $poll->sky->reported;
printf "Sats Used:     %s\n", $poll->sky->used;
printf "Timestamp:     %s\n", $poll->tpv->timestamp;
printf "Latitude:      %s\n", $poll->tpv->lat;
printf "Longitude:     %s\n", $poll->tpv->lon;
printf "Altitude:      %s\n", $poll->tpv->alt;

#print Dumper($gpsd->poll);
