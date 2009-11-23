# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 23;

BEGIN { use_ok( 'Net::GPSD3' ); }
BEGIN { use_ok( 'Net::GPSD3::Base' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::DEVICE' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::DEVICES' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::ERROR' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::Satellite' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::SKY' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::TPV' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::Unknown' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::VERSION' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::WATCH' ); }

my $object;
$object = Net::GPSD3->new();
isa_ok ($object, 'Net::GPSD3');

is($object->strftime, '%Y-%m-%dT%H:%M:%S.%3N', "strftime");

$object = Net::GPSD3::Base->new();
isa_ok ($object, 'Net::GPSD3::Base');

$object = Net::GPSD3::Return::DEVICE->new();
isa_ok ($object, 'Net::GPSD3::Return::DEVICE');

$object = Net::GPSD3::Return::DEVICES->new();
isa_ok ($object, 'Net::GPSD3::Return::DEVICES');

$object = Net::GPSD3::Return::ERROR->new();
isa_ok ($object, 'Net::GPSD3::Return::ERROR');

$object = Net::GPSD3::Return::Satellite->new();
isa_ok ($object, 'Net::GPSD3::Return::Satellite');

$object = Net::GPSD3::Return::SKY->new();
isa_ok ($object, 'Net::GPSD3::Return::SKY');

$object = Net::GPSD3::Return::TPV->new();
isa_ok ($object, 'Net::GPSD3::Return::TPV');

$object = Net::GPSD3::Return::Unknown->new();
isa_ok ($object, 'Net::GPSD3::Return::Unknown');

$object = Net::GPSD3::Return::VERSION->new();
isa_ok ($object, 'Net::GPSD3::Return::VERSION');

$object = Net::GPSD3::Return::WATCH->new();
isa_ok ($object, 'Net::GPSD3::Return::WATCH');
