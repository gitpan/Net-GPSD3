#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper qw{Dumper};
$|=1;

my $debug=shift || 0;

=head1 NAME

Net-GPSD3-Handler.pl - Net::GPSD3 Handler Example

=cut

use Net::GPSD3;
my $gpsd=Net::GPSD3->new; #default host port
$gpsd->addHandler(\&handler);
$gpsd->watch;

sub handler {
  my $object=shift;
  if ($object and $object->class eq "TPV") {
    printf "%s: %s, %s\n", $object->point->datetime->datetime,  $object->lat, $object->lon;
  }
  print Dumper($object) if $debug;
}

=head1 EXAMPLE OUTPUT

  2009-09-19T06:39:15: 38.948861667, -77.351013333
  2009-09-19T06:39:16: 38.948861667, -77.351013333
  2009-09-19T06:39:17: 38.948861667, -77.351011667
  2009-09-19T06:39:18: 38.948861667, -77.351011667
  2009-09-19T06:39:19: 38.948861667, -77.351011667
  2009-09-19T06:39:20: 38.948861667, -77.351011667
  2009-09-19T06:39:21: 38.948861667, -77.351011667
  2009-09-19T06:39:22: 38.948861667, -77.351011667
  2009-09-19T06:39:23: 38.948861667, -77.351013333
  2009-09-19T06:39:24: 38.948863333, -77.351013333

=cut
