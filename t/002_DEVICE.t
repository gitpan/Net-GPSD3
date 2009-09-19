# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 16;

BEGIN { use_ok( 'Net::GPSD3' ); }

my $string=q({"class":"DEVICE","path":"/dev/ttyUSB0","activated":1253333674.67,"flags":1,"driver":"Generic NMEA","native":0,"bps":4800,"parity":"N","stopbits":1,"cycle":1.00});

my $gpsd=Net::GPSD3->new;
isa_ok ($gpsd, 'Net::GPSD3');

my $object=$gpsd->constructor($gpsd->decode($string), string=>$string);
isa_ok ($object, 'Net::GPSD3::Return::DEVICE');
isa_ok ($object->parent, 'Net::GPSD3');

is($object->class, 'DEVICE', 'class');
is($object->string, $string, 'string');

is($object->class, 'DEVICE', 'class');
is($object->path, '/dev/ttyUSB0', 'path');
is($object->activated, '1253333674.67', 'activated');
is($object->flags, '1', 'flags');
is($object->driver, 'Generic NMEA', 'driver');
is($object->native, '0', 'native');
is($object->bps, '4800', 'bps');
is($object->parity, 'N', 'parity');
is($object->stopbits, '1', 'stopbits');
is($object->cycle, '1', 'cycle');

