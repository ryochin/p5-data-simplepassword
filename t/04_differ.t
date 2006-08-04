#
# $Id$

use strict;
use lib qw(blib);
use Data::SimplePassword;

use Test::More tests => 1;

my $sp = Data::SimplePassword->new;

my $n = 100;
my @result;
for(1..$n){
    push @result, $sp->make_password( 32 );
}

ok( scalar &uniq( @result ) == $n, "unique test" );


sub uniq {
    my $seen = {};
    return grep { ! $seen->{$_} ++ } @_;
}

