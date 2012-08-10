package MyModel::Favorite;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "author",
#   typename => "favorite",
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
#   typename => "favorite",
# }
has "date"                         => (
    "is"                           => "rw",
    "store"                        => "yes",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "distribution",
#   typename => "favorite",
# }
has "distribution"                 => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "id",
#   typename => "favorite",
# }
has "id"                           => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "release",
#   typename => "favorite",
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
#   typename => "favorite",
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

