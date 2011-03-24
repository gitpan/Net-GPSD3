#!/usr/bin/perl
use strict;
use warnings;
$|=1;

=head1 NAME

perl-Net-GPSD3-Example.pl - Net::GPSD3 Watcher Example

=cut

use Net::GPSD3;
my $host=shift || undef;
my $port=shift || undef;

my $gpsd=Net::GPSD3->new(host=>$host, port=>$port); #default host port as undef
$gpsd->watch;             #default handler

=head1 EXAMPLE OUTPUT

  VERSION, Release: 2.40dev
  WATCH, Enabled: 1
  TPV, Time: 1253342731.614, Lat: 38.94892, Lon: -77.350908333, Speed: 0.057, Heading: 130.91
  SKY, Time: 1253342732.614, Satellites: 10, Used: 3, PRNs: 18,27,15
  TPV, Time: 1253342732.614, Lat: 38.94892, Lon: -77.35091, Speed: 0.062, Heading: 132.86
  TPV, Time: 1253342733.613, Lat: 38.94892, Lon: -77.35091, Speed: 0.057, Heading: 135.8
  TPV, Time: 1253342734.613, Lat: 38.948921667, Lon: -77.350911667, Speed: 0.046, Heading: 125
  TPV, Time: 1253342735.613, Lat: 38.948923333, Lon: -77.350911667, Speed: 0.051, Heading: 126.35
  TPV, Time: 1253342736.613, Lat: 38.948923333, Lon: -77.350913333, Speed: 0.057, Heading: 123.28
  SKY, Time: 1253342737.613, Satellites: 10, Used: 3, PRNs: 18,27,15
  TPV, Time: 1253342737.613, Lat: 38.948923333, Lon: -77.350913333, Speed: 0.051, Heading: 132.91
  TPV, Time: 1253342738.613, Lat: 38.948923333, Lon: -77.350915, Speed: 0.057, Heading: 124.61

=cut
