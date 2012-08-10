use strict;
use warnings;

package ElasticSearchX::Model::Generator::TypenameTranslator;
BEGIN {
  $ElasticSearchX::Model::Generator::TypenameTranslator::AUTHORITY = 'cpan:KENTNL';
}
{
  $ElasticSearchX::Model::Generator::TypenameTranslator::VERSION = '0.1.0';
}

# ABSTRACT:

use Moo;
use Data::Dump qw( pp );
use MooseX::Has::Sugar qw( rw required weak_ref );

has
  'generator_base' => rw,
  required, weak_ref, handles => [qw( attribute_generator document_generator generated_base_class base_dir )];

sub _words {
  my ( $self, $input ) = @_;
  return split /[^\w]+/, $input;
}

sub translate_to_path {
  my ( $self, %args ) = @_;
  my $package = $self->translate_to_package(%args);

  my (@words) = split /::/, $package;
  if ( not @words ) {
    require Carp;
    Carp::confess("Error translating typename to deploy path: $package ");
  }
  my $basename = pop @words;
  if ( not length $basename ) {
    require Carp;
    Carp::confess("\$basename Path part was 0 characters long:  $package");
  }
  $basename .= '.pm';
  require Path::Class::Dir;
  return Path::Class::Dir->new( $self->base_dir )->subdir( map { ucfirst($_) } @words )->file( ucfirst($basename) );
}

sub translate_to_package {
  my ( $self, %args ) = @_;
  return $self->generated_base_class . '::' . join q{}, map { ucfirst($_) } $self->_words( $args{typename} );
}

no Moo;

1;

__END__
=pod

=encoding utf-8

=head1 NAME

ElasticSearchX::Model::Generator::TypenameTranslator - use Moo;

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

