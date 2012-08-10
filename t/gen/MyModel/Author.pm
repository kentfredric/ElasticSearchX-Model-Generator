package MyModel::Author;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => {
#     fields => {
#                 analyzed  => {
#                                analyzer => "standard",
#                                include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                                store => "yes",
#                                type => "string",
#                              },
#                 asciiname => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "asciiname",
#   typename => "author",
# }
has "asciiname"                    => (
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "true",
#     properties => {
#                     blog    => { type => "string" },
#                     city    => { type => "string" },
#                     dir     => { type => "string" },
#                     email   => { type => "string" },
#                     feed    => { index => "not_analyzed", store => "yes", type => "string" },
#                     pauseid => { type => "string" },
#                     updated => { format => "dateOptionalTime", type => "date" },
#                     url     => { index => "not_analyzed", store => "yes", type => "string" },
#                   },
#   },
#   propertyname => "blog",
#   typename => "author",
# }
has "blog"                         => (
    "dynamic"                      => "1",
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "city",
#   typename => "author",
# }
has "city"                         => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "country",
#   typename => "author",
# }
has "country"                      => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "dir",
#   typename => "author",
# }
has "dir"                          => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "true",
#     properties => {
#                     id => { index => "not_analyzed", store => "yes", type => "string" },
#                     name => { index => "not_analyzed", store => "yes", type => "string" },
#                   },
#   },
#   propertyname => "donation",
#   typename => "author",
# }
has "donation"                     => (
    "dynamic"                      => "1",
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "email",
#   typename => "author",
# }
has "email"                        => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "gravatar_url",
#   typename => "author",
# }
has "gravatar_url"                 => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { type => "geo_point" },
#   propertyname => "location",
#   typename => "author",
# }
has "location"                     => (
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     fields => {
#                 analyzed => {
#                   analyzer => "standard",
#                   include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                   store => "yes",
#                   type => "string",
#                 },
#                 name => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "name",
#   typename => "author",
# }
has "name"                         => (
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "pauseid",
#   typename => "author",
# }
has "pauseid"                      => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "true",
#     properties => {
#                     name => { index => "not_analyzed", store => "yes", type => "string" },
#                     url  => { index => "not_analyzed", store => "yes", type => "string" },
#                   },
#   },
#   propertyname => "perlmongers",
#   typename => "author",
# }
has "perlmongers"                  => (
    "dynamic"                      => "1",
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic => "false",
#     include_in_root => bless(do{\(my $o = 1)}, "JSON::XS::Boolean"),
#     properties => {
#       id => {
#         fields => {
#                     analyzed => {
#                       analyzer => "simple",
#                       include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                       store => "yes",
#                       type => "string",
#                     },
#                     id => { index => "not_analyzed", store => "yes", type => "string" },
#                   },
#         type   => "multi_field",
#       },
#       name => { index => "not_analyzed", store => "yes", type => "string" },
#     },
#     type => "nested",
#   },
#   propertyname => "profile",
#   typename => "author",
# }
has "profile"                      => (
    "dynamic"                      => undef,
    "include_in_root"              => "1",
    "is"                           => "rw",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "region",
#   typename => "author",
# }
has "region"                       => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { format => "dateOptionalTime", store => "yes", type => "date" },
#   propertyname => "updated",
#   typename => "author",
# }
has "updated"                      => (
    "is"                           => "rw",
    "store"                        => "yes",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "user",
#   typename => "author",
# }
has "user"                         => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "website",
#   typename => "author",
# }
has "website"                      => (
    "index"                        => "not_analyzed",
    "is"                           => "rw",
    "store"                        => "yes",
    "type"                         => "string",
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;

