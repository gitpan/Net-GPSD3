

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Net::GPSD3',
    VERSION_FROM => 'lib/Net/GPSD3.pm', # finds \$VERSION
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT     => 'Interface to the gpsd server daemon API Version 3 (JSON).',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                    },
);
