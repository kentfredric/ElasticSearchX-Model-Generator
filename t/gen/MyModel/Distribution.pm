package MyModel::Distribution;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "true",
#     properties => {
#                     active   => { store => "yes", type => "integer" },
#                     closed   => { store => "yes", type => "integer" },
#                     new      => { store => "yes", type => "integer" },
#                     open     => { store => "yes", type => "integer" },
#                     rejected => { store => "yes", type => "integer" },
#                     resolved => { store => "yes", type => "integer" },
#                     source   => { index => "not_analyzed", store => "yes", type => "string" },
#                     stalled  => { store => "yes", type => "integer" },
#                     type     => { index => "not_analyzed", store => "yes", type => "string" },
#                   },
#   },
#   propertyname => "bugs",
#   typename => "distribution",
# }
has "bugs" => (
  "dynamic" => "1",
  "is"      => "rw",
);

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "name",
#   typename => "distribution",
# }
has "name" => (
  "index" => "not_analyzed",
  "is"    => "rw",
  "store" => "yes",
  "type"  => "string",
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;

