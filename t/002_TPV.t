# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 7;

BEGIN { use_ok( 'Net::GPSD3::Return::TPV' ); }

my $object;
$object = Net::GPSD3::Return::TPV->new(
                   'class' => 'TPV',
                   'string' => '{"class":"TPV","tag":"RMC","device":"/dev/ttyUSB0","time":1253063643.608,"ept":0.005,"lat":38.949331667,"lon":-77.350945000,"epx":432.000,"epy":432.000,"epv":92.000,"track":181.7900,"speed":0.941,"mode":3}',
                   'device' => '/dev/ttyUSB0',
                   'tag' => 'RMC',
                   'mode' => 3,
                   'time' => '1253063643.608',
                   'lat' => '38.949331667',
                   'lon' => '-77.350945',
                   'speed' => '0.941',
                   'track' => '181.79',
                   'epx' => '432',
                   'epy' => '432',
                   'ept' => '0.005',
                   'epv' => '92',
                                      );

isa_ok ($object, 'Net::GPSD3::Return::TPV');
isa_ok ($object->point, 'GPS::Point');

is($object->lat, '38.949331667', 'lat');
is($object->point->lat, '38.949331667', 'lat');

is($object->lon, '-77.350945', 'lon');
is($object->point->lon, '-77.350945', 'lon');
