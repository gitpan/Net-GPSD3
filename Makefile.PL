use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Net::GPSD3',
    VERSION_FROM => 'lib/Net/GPSD3.pm',
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT     => 'Interface to the gpsd server daemon protocol Version 3 (JSON).',
    PREREQ_PM    => {
                     'strict'           => 0,
                     'warnings'         => 0,
                     'base'             => 0,
                     'Test::Simple'     => 0.44,
                     'GPS::Point'       => 0,
                     'JSON::XS'         => 0,
                     'IO::Socket::INET' => 0,
                     'Data::Dumper'     => 0,
                    },
);
