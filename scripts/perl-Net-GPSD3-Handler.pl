#!/usr/bin/perl
use strict;
use warnings;
use Net::GPSD3;
use Data::Dumper qw{Dumper};
$|=1;

my $host  = shift || undef; #you can pass zero or ""
my $port  = shift || undef; #you can pass zero or ""
our $debug = shift || 0;

=head1 NAME

perl-Net-GPSD3-Handler.pl - Net::GPSD3 Watcher with Custom Handler

=cut

my $gpsd=Net::GPSD3->new(host=>$host, port=>$port); #default host port is undef
$gpsd->addHandler(\&tpv);
$gpsd->addHandler(\&sky);
$gpsd->watch;

sub tpv {
  my $tpv=shift;
  return unless $tpv->class eq "TPV";
  print Dumper($tpv) if $debug;
  printf "%s: %s, %s, %s\n", $tpv->timestamp,  $tpv->lat, $tpv->lon, $tpv->alt;
}

sub sky {
  my $sky=shift;
  return unless $sky->class eq "SKY";
  print Dumper($sky) if $debug;
  printf "Satellites: %s\n", join(", ", map {$_->prn} $sky->Satellites);
}

=head1 Example Output

  2011-04-08T05:13:10.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:11.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:12.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:13.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:14.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:15.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:16.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:17.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:18.00Z: 37.37143214, -122.015171692, 26.72
  Satellites: 27, 15, 8, 17, 28, 7, 26, 24, 9, 138, 135
  2011-04-08T05:13:19.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:20.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:21.00Z: 37.37143214, -122.015171692, 26.72
  2011-04-08T05:13:22.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:23.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:24.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:25.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:26.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:27.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:28.00Z: 37.371432094, -122.015171632, 26.726
  Satellites: 27, 15, 8, 17, 28, 7, 26, 24, 9, 138, 135
  2011-04-08T05:13:29.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:30.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:31.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:32.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:33.00Z: 37.371432094, -122.015171632, 26.726
  2011-04-08T05:13:34.00Z: 37.371432094, -122.015171632, 26.726

=cut