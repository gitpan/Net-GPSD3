#!/usr/bin/perl
use strict;
use warnings;
use Net::GPSD3;
use Data::Dumper qw{Dumper};
$|=1;

my $host  = shift || undef;
my $port  = shift || undef;
my $debug = shift || 0;

=head1 NAME

perl-Net-GPSD3-Handler.pl - Net::GPSD3 Watcher with Custom Handler

=cut

my $gpsd=Net::GPSD3->new(host=>$host, port=>$port); #default host port is undef
$gpsd->addHandler(\&handler);
$gpsd->watch;

sub handler {
  my $tpv=shift;
  print Dumper($tpv) if $debug;
  if ($tpv and $tpv->class eq "TPV") {
    printf "%s: %s, %s, %s\n", $tpv->timestamp,  $tpv->lat, $tpv->lon, $tpv->alt;
  }
}

=head1 Example Output

  2011-04-05T05:37:11: VERSION, GPSD: 2.96~dev (2011-03-17T02:51:23), Net::GPSD3: 0.15
  2011-04-05T05:37:11: DEVICES, Devices: /dev/cuaU0 (9600 bps uBlox UBX binary-none)
  2011-04-05T05:37:11: WATCH, Enabled: 1
  2011-04-05T05:37:12: TPV, Time: 2011-04-05T05:37:12.00Z, Lat: 37.371420359, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:13: TPV, Time: 2011-04-05T05:37:13.00Z, Lat: 37.371420359, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:14: TPV, Time: 2011-04-05T05:37:14.00Z, Lat: 37.371420359, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:15: TPV, Time: 2011-04-05T05:37:15.00Z, Lat: 37.371420359, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:16: TPV, Time: 2011-04-05T05:37:16.00Z, Lat: 37.371420359, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:17: TPV, Time: 2011-04-05T05:37:17.00Z, Lat: 37.371420359, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:18: TPV, Time: 2011-04-05T05:37:18.00Z, Lat: 37.371420288, Lon: -122.015184863, Speed: 0, Heading: 0
  2011-04-05T05:37:18: SKY, Satellites: 10, Used: 9, PRNs: 28,24,8,11,15,27,26,17,135
  2011-04-05T05:37:19: TPV, Time: 2011-04-05T05:37:19.00Z, Lat: 37.371420334, Lon: -122.015184923, Speed: 0, Heading: 0
  2011-04-05T05:37:20: TPV, Time: 2011-04-05T05:37:20.00Z, Lat: 37.371420334, Lon: -122.015184923, Speed: 0, Heading: 0
  2011-04-05T05:37:21: TPV, Time: 2011-04-05T05:37:21.00Z, Lat: 37.371420334, Lon: -122.015184923, Speed: 0, Heading: 0
  2011-04-05T05:37:22: TPV, Time: 2011-04-05T05:37:22.00Z, Lat: 37.371420334, Lon: -122.015184923, Speed: 0, Heading: 0

=cut
