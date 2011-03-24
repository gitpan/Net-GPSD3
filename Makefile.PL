use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Net::GPSD3',
    VERSION_FROM => 'lib/Net/GPSD3.pm',
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT_FROM=> 'lib/Net/GPSD3.pm',
    PREREQ_PM    => {
                     'Test::Simple'             => 0.44,
                     'GPS::Point'               => 0.10,
                     'JSON::XS'                 => 0,
                     'IO::Socket::INET6'        => 0,
                     'DateTime'                 => 0,
                     'DateTime::Format::W3CDTF' => 0.06, #factional seconds
                    },

    EXE_FILES    => [
                    qw{
                       scripts/perl-Net-GPSD3-Example.pl
                       scripts/perl-Net-GPSD3-Handler.pl
                       scripts/perl-Net-GPSD3-poll.pl
                      }
                    ],

);
