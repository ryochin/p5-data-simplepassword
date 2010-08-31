#

use strict;
use lib qw(blib);
use Data::SimplePassword;

use Test::More;

my $sp = Data::SimplePassword->new;

can_ok( $sp, "provider" );

ok( $sp->provider('') eq '', "empty string returns empty" );

# once a provider is set, it returns the one
SKIP: {
    my $type = 'rand';
    skip "unknown readon", 1 if not eval "\$sp->provider('$type')";

    ok( $sp->provider eq $type, "set name" );
};

done_testing;
