use strict;
use warnings;

package ElasticSearchX::Model::Generator::Generated::Attribute;

# ABSTRACT:

use Moo;
use MooseX::Has::Sugar qw( rw required );

has content => rw, required;

no Moo;

1;
