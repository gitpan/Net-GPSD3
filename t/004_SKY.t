# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 24;

BEGIN { use_ok( 'Net::GPSD3' ); }

my $string=q({"class":"SKY","tag":"GSV","device":"/dev/ttyUSB0","time":1253336487.996,"reported":9,"satellites":[{"PRN":15,"el":75,"az":77,"ss":38,"used":true},{"PRN":21,"el":50,"az":310,"ss":35,"used":true},{"PRN":29,"el":39,"az":219,"ss":0,"used":false},{"PRN":18,"el":32,"az":276,"ss":0,"used":false},{"PRN":5,"el":28,"az":69,"ss":41,"used":true},{"PRN":10,"el":25,"az":69,"ss":40,"used":true},{"PRN":27,"el":22,"az":144,"ss":0,"used":false},{"PRN":9,"el":12,"az":160,"ss":0,"used":false},{"PRN":8,"el":9,"az":39,"ss":41,"used":true}]});

my $gpsd=Net::GPSD3->new;
isa_ok ($gpsd, 'Net::GPSD3');

my $object=$gpsd->constructor($gpsd->decode($string), string=>$string);
isa_ok ($object, 'Net::GPSD3::Return::SKY');
isa_ok ($object->parent, 'Net::GPSD3');

is($object->class, 'SKY', 'class');
is($object->string, $string, 'string');

is($object->tag, 'GSV', 'tag');
is($object->device, '/dev/ttyUSB0', 'device');
is($object->time, '1253336487.996', 'time');
is($object->strftime($object->strftime), '2009-09-19T05:01:27.996', 'datetime');
is($object->reported, '9', 'reported');
is($object->used, '5', 'reported');

my $s;
my @s;

$s=$object->satellites;
isa_ok($s, 'ARRAY', 'satellites 1');
is(scalar(@$s), '9', 'satellites 2');
isa_ok($s->[0], 'HASH', 'satellites 3');

@s=$object->satellites; 
is(scalar(@s), '9', 'satellites 4');
isa_ok($s[0], 'HASH', 'satellites 5');

$s=$object->Satellites; 
isa_ok($s, 'ARRAY', 'Satellites 6');
is(scalar(@$s), '9', 'Satellites 7');
isa_ok($s->[0], 'Net::GPSD3::Return::Satellite', 'Satellites 8');
isa_ok ($s->[0]->parent, 'Net::GPSD3');

#Current architecture does not keep order...
#is($s->[0]->string, '{"PRN":15,"el":75,"az":77,"ss":38,"used":true}', 'string');

@s=$object->Satellites; 
is(scalar(@s), '9', 'Satellites 9');
isa_ok($s[0], 'Net::GPSD3::Return::Satellite', 'Satellites 10');

my $satellite=$s->[0];
isa_ok($satellite, 'Net::GPSD3::Return::Satellite', 'Satellites 11');

