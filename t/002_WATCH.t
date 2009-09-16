# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 9;

BEGIN { use_ok( 'JSON::XS' ); }
BEGIN { use_ok( 'Net::GPSD3::Return::WATCH' ); }

my $object;
$object = Net::GPSD3::Return::WATCH->new(
                 'enable' => JSON::XS::true,
                 'scaled' => JSON::XS::false,
                 'class' => 'WATCH',
                 'string' => '{"class":"WATCH","enable":true,"raw":0,"scaled":false}',
                 'raw' => 0,
                                      );

isa_ok ($object, 'Net::GPSD3::Return::WATCH');

is($object->class, 'WATCH', 'class');
isa_ok($object->enable, 'JSON::XS::Boolean', 'enable');
ok($object->enable, "enable");
isa_ok($object->scaled, 'JSON::XS::Boolean', 'scaled');
ok(!$object->scaled, 'scaled');
is($object->raw, '0', 'raw');

