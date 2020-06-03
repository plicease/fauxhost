use Test2::V0 -no_srand => 1;
use FFI::Platypus 1.00;
use FFI::Platypus::Buffer qw( scalar_to_buffer );
use FFI::Platypus::Memory qw( strdup );

{
  # Sys::Hostname can get the hostname, but it caches the
  # result, and may use one of a number of different methods
  # to get the hostname.
  my $ffi = FFI::Platypus->new( api => 1, lib => [undef] );
  $ffi->attach( gethostname => [ 'opaque', 'size_t' ] => 'int' );
  $ffi->attach_cast( opaque_to_string => 'opaque' => 'string' );
}

delete $ENV{FAUXHOSTNAME};

subtest 'default hostname faux' => sub {
  my $buffer = "\0" x 255;
  my($ptr,$size) = scalar_to_buffer $buffer;
  my $ret = gethostname($ptr,$size);
  is $ret, 0;
  my $hostname = opaque_to_string($ptr);
  is $hostname, 'faux';
};

subtest 'env override' => sub {
  local $ENV{FAUXHOSTNAME} = 'foo';
  my $buffer = "\0" x 255;
  my($ptr,$size) = scalar_to_buffer $buffer;
  my $ret = gethostname($ptr,$size);
  is $ret, 0;
  my $hostname = opaque_to_string($ptr);
  is $hostname, 'foo';
};

subtest 'truncate long hostname' => sub {
  local $ENV{FAUXHOSTNAME} = 'frooblebats';
  my $buffer = "xxyz\0" x 255;
  my($ptr,$size) = scalar_to_buffer $buffer;
  my $ret = gethostname($ptr,3);
  is $ret, 0;
  my $hostname = opaque_to_string($ptr);
  is $hostname, 'froz';
};

done_testing;
