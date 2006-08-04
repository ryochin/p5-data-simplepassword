use 5.00502;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Data::SimplePassword',
    VERSION_FROM      => 'lib/Data/SimplePassword.pm', # finds $VERSION
    PREREQ_PM         => {
	Class::Accessor => 0.01,
	Crypt::Random => 0.01,
	Math::Random::MT => 0.01,
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Data/SimplePassword.pm', # retrieve abstract from module
       AUTHOR         => 'Okamoto RYO <ryo@aquahill.net>') : ()),
);
