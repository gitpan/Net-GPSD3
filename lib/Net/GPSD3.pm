package Net::GPSD3;
use strict;
use warnings;
use base qw{Net::GPSD3::Base};
use JSON::XS qw{};
use IO::Socket::INET qw{};
use Net::GPSD3::Return::Unknown;
use Data::Dumper;
use Time::HiRes qw{time};

our $VERSION='0.07';

=head1 NAME

Net::GPSD3 - Interface to the gpsd server daemon API Version 3 (JSON).

=head1 SYNOPSIS

  use Net::GPSD3;
  my $gpsd=Net::GPSD3->new(host=>"127.0.0.1", port=>2947); #defaults
  $gpsd->addHandler(\&myHandler);
  $gpsd->watch;  

  sub myHandler {
    my $object=shift;
    use Data::Dumper qw{Dumper};
    print Dumper($object);
  }

The Perl one liner

  perl -MNet::GPSD3 -e 'Net::GPSD3->new->watch'

=head1 DESCRIPTION

Net::GPSD3 provides an object client interface to the gpsd server daemon utilizing the version 3.1 API. gpsd is an open source GPS deamon from http://gpsd.berlios.de/.  Support for Version 3 of the API (JSON) was adding to the daemon in version 2.40.  If your daemon is before 2.40 then please use the L<Net::GPSD> package.

=head1 CONSTRUCTOR

=head2 new

Returns a new Net::GPSD3 object.

  my $gpsd=Net::GPSD3->new;
  my $gpsd=Net::GPSD3->new(host=>"127.0.0.1", port=>2947); #defaults

=head1 METHODS

=cut

sub initialize {
  my $self=shift;
  %$self=@_;
  $self->host('127.0.0.1') unless $self->host;
  $self->port(2947)        unless $self->port;
  $self->intersperse(20)   unless defined $self->{"intersperse"}; #0 is off
}

=head2 host

Sets or returns the current gpsd host.

 my $host=$obj->host;

=cut

sub host {
  my $self=shift;
  if (@_) {
    $self->{'host'}=shift;
    undef($self->{'socket'});
  }
  return $self->{'host'};
}

=head2 port

Sets or returns the current gpsd TCP port.

 my $port=$obj->port;

=cut

sub port {
  my $self=shift;
  if (@_) {
    $self->{'port'}=shift;
    undef($self->{'socket'});
  }
  return $self->{'port'};
}

=head2 watch

  $gpsd->watch;  #will not return unless something goes wrong.

=cut

sub watch {
  my $self=shift;
  my @handler=$self->handlers;
  push @handler, \&default_handler unless scalar(@handler);
  $self->socket->send(qq(?WATCH={"enable":true};\n));
  my $object;
  #man 8 gpsd - Each request returns a line of response text ended by a CR/LF.
  local $/="\r\n";
  my $counter=time;
  while (defined($_=$self->socket->getline)) {
    chomp;
    my $object=$self->constructor($self->decode($_), string=>$_);
    foreach my $handler (@handler) {
      &{$handler}($object);
    }
    if ($self->intersperse > 0 and scalar(time) > $counter+$self->intersperse) {
      $self->socket->send("?DEVICES;");
      $counter=time;
    }  
  }
  return $self;
}

=head2 intersperse

Time in seconds to intersperse DEVICES objects into the WATCHER stream.  Disabled <= 0.

  my $intersperse=$self->intersperse; #$ seconds

=cut

sub intersperse {
  my $self=shift;
  $self->{"intersperse"}=shift if @_;
  return $self->{"intersperse"};
}
=head2 addHandler

  $gpsd->addHandler(\&myHandler);
  $gpsd->addHandler(\&myHandler1, \&myHandler2);

=cut

sub addHandler {
  my $self=shift;
  my $array=$self->handlers;
  push @$array, @_ if @_;
  return $self;
}

=head2 handlers

  my @handler=$gpsd->handlers; #()
  my $handler=$gpsd->handlers; #[]

=cut

sub handlers {
  my $self=shift;
  $self->{'handler'}=[] unless ref($self->{'handler'});
  return wantarray ? @{$self->{'handler'}} : $self->{'handler'};
}

=head1 METHODS Internal

=head2 default_handler

=cut

sub default_handler {
  my $object=shift;
  if ($object->class eq "TPV") {
    #print Dumper($object) unless defined ($object->track);
    printf "%s, Time: %s, Lat: %s, Lon: %s, Speed: %s, Heading: %s\n",
             $object->class,
             $object->strftime,
             $object->lat,
             $object->lon,
             $object->speed,
             $object->track;
  } elsif ($object->class eq "SKY") {
    printf "%s, Time: %s, Satellites: %s, Used: %s, PRNs: %s\n",
             $object->class,
             $object->strftime,
             $object->reported,
             $object->used,
             join(",", map {$_->prn} grep {$_->used} $object->Satellites),
  } elsif ($object->class eq "VERSION") {
    printf "%s, GPSD: %s (%s), %s: %s\n",
             $object->class,
             $object->release,
             $object->revision,
             ref($object->parent),
             $object->parent->VERSION;
  } elsif ($object->class eq "WATCH") {
    printf "%s, Enabled: %s\n",
             $object->class,
             $object->enable;
  } elsif ($object->class eq "DEVICES") {
    printf "%s, Devices: %s\n", $object->class,
             join(", ", map {sprintf("%s (%s bps) => %s (%s)",
                               $_->path,
                               $_->bps,
                               $_->driver,
                               $_->subtype)}
               $object->Devices);
  } elsif ($object->class eq "DEVICE") {
    printf qq{%s, Device: %s (%s bps)=> %s (%s)\n},
             $object->class,
             $object->path,
             $object->bps,
             $object->driver,
             $object->subtype;
  } elsif ($object->class eq "ERROR") {
    printf qq{%s, Message: "%s"\n},
             $object->class,
             $object->message;
  } else {
    print Dumper($object);
  }
  #print Dumper($object);
}

=head2 socket

Returns the cached IO::Socket::INET object

  my $socket=$gpsd->socket;  #try to reconnect on failure

=cut

sub socket {
  my $self=shift;
  unless (defined($self->{'socket'}) and
            defined($self->{'socket'}->connected)) { 
    $self->{"socket"}=IO::Socket::INET->new(PeerAddr=>$self->host,
                                            PeerPort=>$self->port);
    die(sprintf("Error: Cannot connect to gpsd://%s:%s/.\n",
      $self->host, $self->port)) unless defined($self->{"socket"});
  }
  return $self->{'socket'};
}

=head2 json

Returns the cached JSON::XS object

=cut

sub json {
  my $self=shift;
  #Do I need to support JSON::PP?
  $self->{"json"}=JSON::XS->new unless ref($self->{"json"}) eq "JSON::XS";
  return $self->{"json"};
}

=head2 decode

Returns a perl data structure given a JSON formated string.

  my %data=$gpsd->decode($string); #()
  my $data=$gpsd->decode($string); #{}

=cut

sub decode {
  my $self=shift;
  my $string=shift;
  my $data=eval {$self->json->decode($string)};
  if ($@) {
    $data={class=>"ERROR", message=>"Invalid JSON"};
  }
  return wantarray ? %$data : $data;
}

=head2 encode

Returns a JSON string from a perl data structure

=cut

sub encode {
  my $self=shift;
  my $data=shift;
  my $string=$self->json->encode($data);
  return $string;
}

=head2 constructor

Constructs a class object by lazy loading the classes.

  my $obj=$gpsd->constructor(%$data);
  my $obj=$gpsd->constructor(class=>"DEVICE",
                             string=>'{...}',
                             ...);

Returns and object in the Net::GPSD3::Return::* namespace.

=cut

sub constructor {
  my $self=shift;
  my %data=@_;
  $data{"class"}||="undef";
  my $class=join("::", ref($self), "Return", $data{"class"});
  eval("use $class");
  if ($@) { #Failed to load class
    return Net::GPSD3::Return::Unknown->new(parent=>$self, %data);
  } else {
    return $class->new(parent=>$self, %data);
  }
}

=head2 strftime

The format the L<DateTime> objects

=cut

sub strftime {
  return q{%Y-%m-%dT%H:%M:%S.%3N};
}

=head1 BUGS

Log on RT and Send to gpsd-dev email list

=head1 SUPPORT

Try gpsd-dev email list

=head1 AUTHOR

  Michael R. Davis
  CPAN ID: MRDVT
  STOP, LLC
  domain=>michaelrdavis,tld=>com,account=>perl
  http://www.stopllc.com/

=head1 COPYRIGHT

This program is free software licensed under the...

  The BSD License

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

L<Net::GPSD>, L<GPS::Point>

=cut

1;
