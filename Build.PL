#
# $Id$

use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::SimplePassword',
    license             => 'perl',
    dist_author         => 'Ryo Okamoto <ryo at aquahill dot net>',
    dist_version_from   => 'lib/Data/SimplePassword.pm',
#    auto_features => {
#	xs_support => {
#	    description => "XS version of Math::Random::MT",
#	    requires => {
#		'Math::Random::MT' => 0,
#	    }
#	}
#    },
    build_requires => {
        'Test::More' => 0,
	'List::MoreUtils' => 0,
    },
    requires => {
	'CLASS' => 0,
	'Class::Accessor' => 0,
	'Class::Data::Inheritable' => 0,
	'Crypt::Random' => 0,
	'Math::Random::MT::Perl' => 0,
	'UNIVERSAL::require' => 0,
    },
    recommends => {
	'Math::Random::MT' => 0,
    },
    script_files => [ 'rndpassword' ],
    add_to_cleanup => [ 'Data-SimplePassword-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
