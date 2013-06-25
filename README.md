# NAME

Data::SimplePassword - Simple random password generator

# SYNOPSIS

    use Data::SimplePassword;

    my $sp = Data::SimplePassword->new;
    $sp->chars( 0..9, 'a'..'z', 'A'..'Z' );    # optional

    my $password = $sp->make_password( 8 );    # length

# DESCRIPTION

YA very easy-to-use but a bit strong random password generator.

# METHODS

- __new__

        my $sp = Data::SimplePassword->new;

    Makes a Data::SimplePassword object.

- __chars__

        $sp->chars( 0..9, 'a'..'z', 'A'..'Z' );    # default
        $sp->chars( 0..9, 'a'..'z', 'A'..'Z', qw(+ /) );    # b64-like
        $sp->chars( 0..9 );
        my @c = $sp->chars;    # returns the current values

    Sets an array of characters you want to use as your password string.

- __make\_password__

        my $password = $sp->make_password( 8 );    # default
        my $password = $sp->make_password( 1024 );

    Makes password string and just returns it. You can set the byte length as an integer.

# EXTRA METHODS

- __provider__

        $sp->provider("devurandom");    # optional

    Sets a type of random number generator, see Crypt::Random::Provider::\* for details.

- __is\_available\_provider__

        $sp->is_available_provider("devurandom");

    Returns true when the type is available.

# COMMAND-LINE TOOL

A useful command named rndpassword(1) will be also installed. Type __man rndpassword__ for details.

# DEPENDENCY

CLASS, Class::Accessor, Class::Data::Inheritable, Crypt::Random, Math::Random::MT (or Math::Random::MT::Perl),
UNIVERSAL::require

# SEE ALSO

Crypt::GeneratePassword, Crypt::RandPasswd, String::MkPasswd, Data::Random::String

http://en.wikipedia.org/wiki//dev/random

# REPOSITORY

https://github.com/ryochin/p5-data-simplepassword

# AUTHOR

Ryo Okamoto <ryo@aquahill.net>

# COPYRIGHT & LICENSE

Copyright (c) Ryo Okamoto, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
