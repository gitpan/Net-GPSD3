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

2011-03-26T22:23:45.00Z: 37.371417366, -122.015186131, 29.278
2011-03-26T22:23:46.00Z: 37.371417366, -122.015186131, 29.278
2011-03-26T22:23:47.00Z: 37.371417366, -122.015186131, 29.278
2011-03-26T22:23:48.00Z: 37.371417366, -122.015186131, 29.278
2011-03-26T22:23:49.00Z: 37.371417366, -122.015186131, 29.278
2011-03-26T22:23:50.00Z: 37.371417366, -122.015186131, 29.278
2011-03-26T22:23:51.00Z: 37.371417366, -122.015186131, 29.278

=cut
