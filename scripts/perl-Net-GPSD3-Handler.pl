#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper qw{Dumper};
$|=1;

my $host  = shift || undef;
my $port  = shift || undef;
my $debug = shift || 0;

=head1 NAME

perl-Net-GPSD3-Handler.pl - Net::GPSD3 Watcher with Custom Handler

=cut

use Net::GPSD3;
my $gpsd=Net::GPSD3->new(host=>$host, port=>$port); #default host port is undef
$gpsd->addHandler(\&handler);
$gpsd->watch;

sub handler {
  my $object=shift;
  print Dumper($object) if $debug;
  if ($object and $object->class eq "TPV") {
    printf "%s: %s, %s\n", $object->time,  $object->lat, $object->lon;
  }
}

=head1 EXAMPLE OUTPUT

  2011-03-19T04:04:47.00Z: 37.371433298, -122.01518499
  2011-03-19T04:04:48.00Z: 37.371433298, -122.01518499
  2011-03-19T04:04:49.00Z: 37.371433298, -122.01518499
  2011-03-19T04:04:50.00Z: 37.371433251, -122.01518493
  2011-03-19T04:04:51.00Z: 37.371433251, -122.01518493
  2011-03-19T04:04:52.00Z: 37.371433251, -122.01518493
  2011-03-19T04:04:53.00Z: 37.371433251, -122.01518493
  2011-03-19T04:04:54.00Z: 37.371433251, -122.01518493

=cut
