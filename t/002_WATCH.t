# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 12;

BEGIN { use_ok( 'JSON::XS' ); }
BEGIN { use_ok( 'Net::GPSD3' ); }

my $string=q({"class":"WATCH","enable":false,"raw":0,"scaled":false});

my $gpsd=Net::GPSD3->new;
isa_ok ($gpsd, 'Net::GPSD3');

my $object=$gpsd->constructor($gpsd->decode($string), string=>$string);
isa_ok ($object, 'Net::GPSD3::Return::WATCH');
isa_ok ($object->parent, 'Net::GPSD3');
is($object->string, $string, 'string');

is($object->class, 'WATCH', 'class');
isa_ok($object->enable, 'JSON::XS::Boolean', 'enable');
ok(!$object->enable, "enable");
isa_ok($object->scaled, 'JSON::XS::Boolean', 'scaled');
ok(!$object->scaled, 'scaled');
is($object->raw, '0', 'raw');

