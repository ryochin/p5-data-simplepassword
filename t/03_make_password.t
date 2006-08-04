#
# $Id$

use strict;
use lib qw(blib);
use Data::SimplePassword;

use Test::More tests => 14;

use constant SUCCESS => 1;
use constant FAILURE => 0;

my $sp = Data::SimplePassword->new;
#$sp->seed_num( 624 );    # up to 624

can_ok( $sp, 'make_password' );

my @test = (
  [ [] => 8, SUCCESS ],
  [ [ 0..9, 'a'..'Z' ] => 1, SUCCESS ],
  [ [ 0..9, 'a'..'Z' ] => 1024, SUCCESS ],
  [ [ 0..9, 'a'..'Z' ] => 1024 ** 2, SUCCESS ],    # 1MB
  [ [ 0 ] => 8, SUCCESS ],
  [ [ 1 ] => 8, SUCCESS ],
  [ [ 'a'..'Z', qw(+ /) ] => 8, SUCCESS ],

  [ [ 0..9 ] => 'foo', FAILURE ],
);

for my $test ( @test ){
  my @chars = @{ $test->[0] };
  my ($len, $rc) = @{$test}[1,2];

  diag("wait a moment ..")
    if $len =~ /^\d+$/ && $len > 2000;

  $sp->chars( @chars ) if scalar @chars;
  my $password = eval { $sp->make_password( $len ) };

  if( $rc == SUCCESS ){
    my $regex = quotemeta join '', @chars;
    ok( $password =~ /^[$regex]+$/, "regex" ) if $regex;
    ok( length( $password ) == $len, "length" );
  }
  else{
    ok( ! ( defined $password and $password ne '' ), "fail" );
  }
}

