package MyModel::Module;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "associated_pod",
#   typename => "module",
# }
has "associated_pod" => (
  "index" => "not_analyzed",
  "is"    => "rw",
  "store" => "yes",
  "type"  => "string",
);

# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "boolean" },
#   propertyname => "authorized",
#   typename => "module",
# }
has "authorized" => (
  "is"    => "rw",
  "store" => "yes",
  "type"  => "boolean",
);

# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "boolean" },
#   propertyname => "indexed",
#   typename => "module",
# }
has "indexed" => (
  "is"    => "rw",
  "store" => "yes",
  "type"  => "boolean",
);

# do {
#   my $a = {
#     index => "cpan_v1",
#     propertydata => {
#       fields => {
#                   analyzed => {
#                     analyzer => "standard",
#                     include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                     store => "yes",
#                     type => "string",
#                   },
#                   camelcase => {
#                     analyzer => "camelcase",
#                     include_in_all => 'fix',
#                     store => "yes",
#                     type => "string",
#                   },
#                   lowercase => {
#                     analyzer => "lowercase",
#                     include_in_all => 'fix',
#                     store => "yes",
#                     type => "string",
#                   },
#                   name => { index => "not_analyzed", store => "yes", type => "string" },
#                 },
#       type   => "multi_field",
#     },
#     propertyname => "name",
#     typename => "module",
#   };
#   $a->{propertydata}{fields}{camelcase}{include_in_all} = \${$a->{propertydata}{fields}{analyzed}{include_in_all}};
#   $a->{propertydata}{fields}{lowercase}{include_in_all} = \${$a->{propertydata}{fields}{analyzed}{include_in_all}};
#   $a;
# }
has "name" => ( "is" => "rw", );

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "version",
#   typename => "module",
# }
has "version" => (
  "index" => "not_analyzed",
  "is"    => "rw",
  "store" => "yes",
  "type"  => "string",
);

# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "float" },
#   propertyname => "version_numified",
#   typename => "module",
# }
has "version_numified" => (
  "is"    => "rw",
  "store" => "yes",
  "type"  => "float",
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;

