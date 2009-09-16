# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 7;

BEGIN { use_ok( 'Net::GPSD3::Return::VERSION' ); }

my $object;
$object = Net::GPSD3::Return::VERSION->new(
                 'api_minor' => 1,
                 'api_major' => 3,
                 'rev' => '$Id: gpsd.c 5957 2009-08-23 15:45:54Z esr $',
                 'release' => '2.40dev',
                 'class' => 'VERSION',
                 'string' => '{"class":"VERSION","release":"2.40dev","rev":"$Id: gpsd.c 5957 2009-08-23 15:45:54Z esr $","api_major":3,"api_minor":1}',

                                      );

isa_ok ($object, 'Net::GPSD3::Return::VERSION');

is($object->class, 'VERSION', 'class');
is($object->api_minor, '1', 'api_minor');
is($object->api_major, '3', 'api_major');
is($object->release, '2.40dev', 'release');
is($object->rev, '$Id: gpsd.c 5957 2009-08-23 15:45:54Z esr $', 'rev');

