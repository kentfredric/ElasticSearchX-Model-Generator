use strict;
use warnings;

package ElasticSearchX::Model::Generator::Generated::Attribute;

# ABSTRACT: Result container for a generated attribute

use Moo;
use MooseX::Has::Sugar qw( rw required );

=attr content

  rw, required

=cut

has content => rw, required;

no Moo;

1;
