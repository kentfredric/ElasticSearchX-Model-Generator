package MyModel::Profile;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => {
#     fields => {
#                 analyzed => {
#                   analyzer => "simple",
#                   include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                   store => "yes",
#                   type => "string",
#                 },
#                 id => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "id",
#   typename => "profile",
# }
has "id" => ( "is" => "rw", );

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "name",
#   typename => "profile",
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

