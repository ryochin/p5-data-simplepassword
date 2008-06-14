#
# $Id$

use strict;
use lib qw(blib);
use Data::SimplePassword;

use Test::More;

if( ! $ENV{RUN_HEAVY_TEST} ){
    plan skip_all => "define RUN_HEAVY_TEST to run these tests";
}
else{
    require List::MoreUtils;
    plan tests => 1;

    my $sp = Data::SimplePassword->new;

    my $n = 1000;
    my @result;
    for(1..$n){
	push @result, $sp->make_password( 32 );
    }

    ok( scalar List::MoreUtils::uniq( @result ) == $n, "unique test" );
}

