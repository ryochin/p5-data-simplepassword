#
# $Id$

use strict;
use lib qw(blib);
use Data::SimplePassword;

use Test::More tests => 3;

BEGIN { use_ok( 'Data::SimplePassword' ) }

can_ok( 'Data::SimplePassword', 'new' );
ok( Data::SimplePassword->new, "" );


