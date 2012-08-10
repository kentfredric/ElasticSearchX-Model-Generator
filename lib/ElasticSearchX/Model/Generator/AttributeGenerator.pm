use strict;
use warnings;

package ElasticSearchX::Model::Generator::AttributeGenerator;

# ABSTRACT:

use Moo;
use Data::Dump qw( pp quote );
use MooseX::Has::Sugar qw( rw required weak_ref );

has 'generator_base' => rw, required, weak_ref, handles => [qw( document_generator typename_translator )];

my $attribute_template = <<'EOF';
%s
has %-30s => ( is => rw =>, );
EOF
chomp $attribute_template;

sub generate {
  my ( $self, %args ) = @_;
  require ElasticSearchX::Model::Generator::Generated::Attribute;
  my $definition = pp(\%args);
  $definition =~ s/^/# /gsm;
  return ElasticSearchX::Model::Generator::Generated::Attribute->new(
    content => ( sprintf $attribute_template, $definition, quote( $args{propertyname} ) ) );
}

no Moo;
1;
