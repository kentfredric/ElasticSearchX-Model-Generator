use strict;
use warnings;

package ElasticSearchX::Model::Generator::DocumentGenerator;

# ABSTRACT: Moose Class generation back end for Documents/Types.

use 5.10.0;
use Moo;
use Data::Dump qw( pp );
use MooseX::Has::Sugar qw( rw required weak_ref );

=attr generator_base

  rw, required, weak_ref

=cut

has 'generator_base' => rw, required, weak_ref, handles => [qw( attribute_generator typename_translator )];

=method generate

  $generated_document = $documentgenerator->generate(
    index        => ... Name of current index ...
    typename     => ... Name of the type we're generating ...
  );
  $generated_document->isa(ElasticSearchX::Model::Generator::Generated::Document);

=cut

sub generate {
  my ( $self, %args ) = @_;

  my $class = $self->typename_translator->translate_to_package( typename => $args{typename} );
  my $path = $self->typename_translator->translate_to_path( typename => $args{typename} );
  my @attributes;
  for my $property_name ( sort { $a cmp $b } $self->generator_base->property_names( $args{index}, $args{typename} ) ) {
    my $property = $self->generator_base->property( $args{index}, $args{typename}, $property_name );
    push @attributes,
      $self->attribute_generator->generate(
      index        => $args{index},
      typename     => $args{typename},
      propertyname => $property_name,
      propertydata => $property,
      );
  }

  require ElasticSearchX::Model::Generator::Generated::Document;
  return ElasticSearchX::Model::Generator::Generated::Document->new(
    package => $class,
    path    => $path,
    content => $self->_fill_template(
      class      => $class,
      typename   => $args{typename},
      attributes => ( join qq{\n}, map { $_->content } @attributes )
    ),
  );
}

=p_method _template_string

=cut

sub _template_string {
  return state $document_template = <<'EOF';
use strict;
use warnings FATAL => 'all';

package %s;

# ABSTRACT: Generated model for %s

use Moose;
use ElasticSearchX::Model::Document v0.1.5;

%s

no Moose;
__PACKAGE__->meta->make_immutable;

1;

EOF

}

=p_method _fill_template

=cut

sub _fill_template {
  my ( $self, %args ) = @_;
  return sprintf
    $self->_template_string,
    $args{class},
    $args{typename},
    $args{attributes};
}

no Moo;

1;
