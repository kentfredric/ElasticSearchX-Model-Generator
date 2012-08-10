use strict;
use warnings;

package ElasticSearchX::Model::Generator::DocumentGenerator;

# ABSTRACT:

use Moo;
use Data::Dump qw( pp );
use MooseX::Has::Sugar qw( rw required weak_ref );

has 'generator_base' => rw, required, weak_ref, handles => [qw( attribute_generator typename_translator )];

my $document_template = <<'EOF';
package %s;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

%s

no Moose;
__PACKAGE__->meta->make_immutable;

1;

EOF

sub generate {
  my ( $self, %args ) = @_;
  my $class = $self->typename_translator->translate_to_package( typename => $args{typename} );
  my $path = $self->typename_translator->translate_to_path( typename => $args{typename} );
  my @attributes;
  for my $property_name ( sort { $a cmp $b } $self->generator_base->property_names( $args{index}, $args{typename} ) ) {
    my $property = $self->generator_base->property( $args{index}, $args{typename}, $property_name );
    push @attributes, $self->attribute_generator->generate(
      index        => $args{index},
      typename     => $args{typename},
      propertyname => $property_name,
      propertydata => $property,
    );
  }

  require ElasticSearchX::Model::Generator::Generated::Document;
  return ElasticSearchX::Model::Generator::Generated::Document->new(
    path    => $path,
    content => ( sprintf $document_template, $class, join qq{\n}, map { $_->content } @attributes ),
  );
}

no Moo;

1;
