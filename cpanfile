requires 'CLASS';
requires 'Class::Accessor';
requires 'Class::Data::Inheritable';
requires 'Crypt::Random';
requires 'Math::Random::MT::Perl';
requires 'UNIVERSAL::require';

recommends 'Math::Random::MT';

on build => sub {
    requires 'List::MoreUtils';
    requires 'Test::More', '0.88';
};
