use strict;
use warnings;

package ElasticSearchX::Model::Generator::AttributeGenerator;

# ABSTRACT:

use Moo;
use Data::Dump qw( pp quote );
use MooseX::Has::Sugar qw( rw required weak_ref );

has 'generator_base' => rw, required, weak_ref, handles => [qw( document_generator typename_translator )];

my $attribute_template=<<'EOF';
has %-30s => ( is => rw =>, );
EOF

sub generate {
  my ( $self, %args ) = @_;
  return { content => ( sprintf 'has %-30s => ( is => rw =>, );', quote( $args{propertyname} ) ) };
}

no Moo;
1;
