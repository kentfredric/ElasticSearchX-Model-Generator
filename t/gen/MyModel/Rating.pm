package MyModel::Rating;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "author",
#   typename => "rating",
# }
has "author"                       => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { format => "dateOptionalTime", store => "yes", type => "date" },
#   propertyname => "date",
#   typename => "rating",
# }
has "date"                         => (
    "is"                           => "rw",
    "store"                        => "yes",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "false",
#     properties => {
#                     documentation => { index => "not_analyzed", store => "yes", type => "string" },
#                   },
#   },
#   propertyname => "details",
#   typename => "rating",
# }
has "details"                      => (
    "dynamic"                      => undef,
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "distribution",
#   typename => "rating",
# }
has "distribution"                 => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "false",
#     properties => {
#                     user  => { index => "not_analyzed", store => "yes", type => "string" },
#                     value => { store => "yes", type => "boolean" },
#                   },
#   },
#   propertyname => "helpful",
#   typename => "rating",
# }
has "helpful"                      => (
    "dynamic"                      => undef,
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "float" },
#   propertyname => "rating",
#   typename => "rating",
# }
has "rating"                       => (
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "float",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "release",
#   typename => "rating",
# }
has "release"                      => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "user",
#   typename => "rating",
# }
has "user"                         => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;

