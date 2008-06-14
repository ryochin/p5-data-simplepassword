# 
# $URL$
# $Id$

use strict;
use Test::More;

unless( eval { require Test::Perl::Critic; import Test::Perl::Critic -profile => "t/perlcriticrc" } ){ 
    plan skip_all => "Test::Perl::Critic not installed";
}

Test::Perl::Critic::all_critic_ok("lib");
