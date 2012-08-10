use strict;
use warnings;

package ElasticSearchX::Model::Generator::TypenameTranslator;

# ABSTRACT: Transform upstream type/document names to downstream Package/Class/File names.

use Moo;
use Data::Dump qw( pp );
use MooseX::Has::Sugar qw( rw required weak_ref );

=attr generator_base

  rw, required, weak_ref

=cut

has
  'generator_base' => rw,
  required, weak_ref, handles => [qw( attribute_generator document_generator generated_base_class base_dir )];

=p_method _words

  @words = $instance->_words( $string );

=cut

sub _words {
  my ( $self, $input ) = @_;
  return split /\W+/, $input;
}

=method translate_to_path

  my $path = $instance->translate_to_path( 'file' );
  # ->  /my/base/dir/File.pm

=cut

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
  return Path::Class::Dir->new( $self->base_dir )->subdir( map { ucfirst $_ } @words )->file( ucfirst $basename );
}

=method translate_to_package

  my $package = $instance->translate_to_package('file');
  # -> MyBaseClass::File

=cut

sub translate_to_package {
  my ( $self, %args ) = @_;
  return sprintf q{%s::%s}, $self->generated_base_class, join q{}, map { ucfirst $_ } $self->_words( $args{typename} );
}

no Moo;

1;
