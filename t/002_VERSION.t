# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 10;

BEGIN { use_ok( 'Net::GPSD3' ); }

my $string=q({"class":"VERSION","release":"2.40dev","rev":"$Id: gpsd.c 5957 2009-08-23 15:45:54Z esr $","api_major":3,"api_minor":1});

my $gpsd=Net::GPSD3->new;
isa_ok ($gpsd, 'Net::GPSD3');

my $object=$gpsd->constructor($gpsd->decode($string), string=>$string);
isa_ok ($object, 'Net::GPSD3::Return::VERSION');
isa_ok ($object->parent, 'Net::GPSD3');
is($object->string, $string, 'string');

is($object->class, 'VERSION', 'class');
is($object->release, '2.40dev', 'release');
is($object->rev, '$Id: gpsd.c 5957 2009-08-23 15:45:54Z esr $', 'rev');
is($object->api_major, '3', 'api_major');
is($object->api_minor, '1', 'api_minor');
