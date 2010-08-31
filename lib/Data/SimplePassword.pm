#

package Data::SimplePassword;

use strict;
use 5.00502;
use vars qw($VERSION);
use base qw(Class::Accessor::Fast Class::Data::Inheritable);
use CLASS;
use Carp;
use UNIVERSAL::require;
use Crypt::Random ();

$VERSION = '0.06';

CLASS->mk_classdata( qw(class) );
CLASS->mk_accessors( qw(seed_num) );

{
    Math::Random::MT->use
	? CLASS->class("Math::Random::MT")
	: Math::Random::MT::Perl->use
	    ? CLASS->class("Math::Random::MT::Perl")
	    : CLASS->class("Data::SimplePassword::exception");
}

sub _default_chars { ( 0..9, 'a'..'z', 'A'..'Z' ) }

sub new {
    my $param = shift;
    my $class = ref $param || $param;
    my %args = (
	chars => undef,
	seed_num => 1,    # now internal use only, up to 624
	provider => '',    # see Crypt::Random::Generator
	@_
    );

    return bless { %args }, $class;
}

sub provider {
    my $self = shift;
    my ($provider) = @_;

    if( defined $provider and $provider ne '' ){
	# check
	my $pkg = sprintf "Crypt::Random::Provider::%s", $provider;
	eval "use $pkg; $pkg->available()"
	    or croak "RNG provider '$_[0]' is not available.";

	$self->{provider} = $provider;
    }

    return $self->{provider};
}

sub chars {
    my $self = shift;

    if( scalar @_ > 0 ){

	croak "each chars must be a letter or an integer."
	    if scalar grep { length( $_ ) != 1 } @_;

	$self->{chars} = [ @_ ];
    }

    return wantarray ? @{ $self->{chars} } : $self->{chars};
}

sub make_password {
    my $self = shift;
    my $len = shift || 8;

    croak "length must be an integer."
	unless $len =~ /^\d+$/o;

    my @chars = defined $self->chars && ref $self->chars eq 'ARRAY'
	? @{ $self->chars }
	: $self->_default_chars;

    my $gen = $self->class->new(
	map { Crypt::Random::makerandom( Size => 32, Strength => 1, Provider => $self->provider ) } 1 .. $self->seed_num
    );

    my $password;
    while( $len-- ){
	$password .= $chars[ $gen->rand( scalar @chars ) ];
    }

    return $password;
}

{    package    # hide from PAUSE
	Data::SimplePassword::exception;

    use strict;
    use Carp;

    AUTOLOAD { croak "couldn't find any suitable MT classes." }
}

1;

__END__

=head1 NAME

Data::SimplePassword - Simple random password generator

=head1 SYNOPSIS

 use Data::SimplePassword;

 my $sp = Data::SimplePassword->new;
 $sp->chars( 0..9, 'a'..'z', 'A'..'Z' );    # optional

 my $password = $sp->make_password( 8 );    # length

=head1 DESCRIPTION

YA very easy-to-use but a bit strong random password generator.

=head1 METHODS

=over 4

=item B<new>

 my $sp = Data::SimplePassword->new;

Makes a Data::SimplePassword object.

=item B<provider>

 $sp->provider("devurandom");    # optional

Sets a type of radmon number generator, see Crypt::Random::Provider::* for details.

=item B<chars>

 $sp->chars( 0..9, 'a'..'z', 'A'..'Z' );    # default
 $sp->chars( 0..9, 'a'..'z', 'A'..'Z', qw(+ /) );    # b64-like
 $sp->chars( 0..9 );
 my @c = $sp->chars;    # returns the current values

Sets an array of characters you want to use as your password string.

=item B<make_password>

 my $password = $sp->make_password( 8 );    # default
 my $password = $sp->make_password( 1024 );

Makes password string and just returns it. You can set the byte length as an integer.

=back

=head1 COMMAND-LINE TOOL

A useful command named rndpassword(1) will be also installed. Type B<man rndpassword> for details.

=head1 DEPENDENCY

CLASS, Class::Accessor, Class::Data::Inheritable, Crypt::Random, Math::Random::MT (or Math::Random::MT::Perl),
UNIVERSAL::require

=head1 SEE ALSO

Crypt::GeneratePassword, Crypt::RandPasswd, Data::RandomPass, String::MkPasswd, Data::Random::String

http://en.wikipedia.org/wiki//dev/random

=head1 AUTHOR

Ryo Okamoto C<< <ryo at aquahill dot net> >>

=head1 COPYRIGHT & LICENSE

Copyright 2006-2010 Ryo Okamoto, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

