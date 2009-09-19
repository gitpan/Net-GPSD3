# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 25;

BEGIN { use_ok( 'Net::GPSD3' ); }

my $string=q({"class":"TPV","tag":"RMC","device":"/dev/ttyUSB0","time":1253334480.119,"ept":0.005,"lat":38.949656667,"lon":-77.350946667,"epx":750.000,"epy":750.000,"epv":1150.000,"track":17.0300,"speed":0.211,"mode":3});

my $gpsd=Net::GPSD3->new;
isa_ok ($gpsd, 'Net::GPSD3');

my $object=$gpsd->constructor($gpsd->decode($string), string=>$string);
isa_ok ($object, 'Net::GPSD3::Return::TPV');
isa_ok ($object->parent, 'Net::GPSD3');
is($object->string, $string, 'string');

isa_ok ($object->point, 'GPS::Point');

is($object->class, 'TPV', 'class');
is($object->tag, "RMC", "tag");
is($object->point->tag, "RMC", "tag");
is($object->device, "/dev/ttyUSB0", "device");
is($object->time, "1253334480.119", "time");
is($object->point->time, "1253334480.119", "time");
is($object->ept, "0.005", "ept");
is($object->lat, "38.949656667", "lat");
is($object->point->lat, '38.949656667', 'lat');
is($object->lon, "-77.350946667", "lon");
is($object->point->lon, '-77.350946667', 'lon');
is($object->epx, "750", "epx");
is($object->epy, "750", "epy");
is($object->epv, "1150", "epv");
is($object->track, "17.03", "track");
is($object->point->heading, "17.03", "track");
is($object->speed, "0.211", "speed");
is($object->point->speed, "0.211", "speed");
is($object->mode, "3", "mode");
