#
# $Id$

package Data::SimplePassword;

use strict;
use 5.00502;
use vars qw($VERSION);
use base qw(Class::Accessor::Fast);
use Carp;
use Crypt::Random ();
use Math::Random::MT ();

$VERSION = '0.01';

sub new {
    my $param = shift;
    my $class = ref $param || $param;
    my %args = (
	chars => undef,
	seed_num => 1,    # now internal only, up to 624
	@_
    );

    $class->mk_accessors( qw(seed_num) );

    return bless { %args }, $class;
}

sub chars {
    my $self = shift;

    if( scalar @_ > 0 ){

	croak "each char must be a letter or an integer."
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

    my @chars = ref $self->chars eq 'ARRAY' ? @{ $self->chars } : ( 0..9, 'a'..'z', 'A'..'Z' );

    my $gen = Math::Random::MT->new( map { Crypt::Random::makerandom( Size => 32, Strength => 1 ) } 1 .. $self->seed_num );
    my $password = join '', @chars[ map { $gen->rand( scalar @chars ) } (1 .. $len) ];

    return $password;
}

1;

__END__

=pod

=head1 NAME

Data::SimplePassword - Simple Password Generator

=head1 SYNOPSIS

 use Data::SimplePassword;
 
 my $sp = Data::SimplePassword->new;
 $sp->chars( 0..9, 'a'..'z', 'A'..'Z' );
 
 my $password = $sp->make_password( 8 );    # length

=head1 DESCRIPTION

YA very easy-to-use but a bit strong random password generator.

=head1 METHODS

=over 4

=item B<chars>

 $sp->chars( 0..9, 'a'..'f', 'A'..'Z' );    # default
 $sp->chars( 0..9, 'a'..'z', qw(+ /) );
 $sp->chars( 0..9, 'a'..'f' );

Set characters you want to use in your password string.

=item B<make_password>

  my $password = $sp->make_password( 8 );    # default
  my $password = $sp->make_password( 1024 );

Make password and just return it. You can set the byte length as an integer.

=back

=head1 DEPENDENCY

Class::Accessor, Crypt::Random, Math::Random::MT

=head1 SEE ALSO

Crypt::GeneratePassword, Crypt::RandPasswd, Data::RandomPass, String::MkPasswd

=head1 AUTHOR

Okamoto RYO <ryo@aquahill.net>

=cut

