package MyModel::Mirror;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "A_or_CNAME",
#   typename => "mirror",
# }
has "A_or_CNAME"                   => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "aka_name",
#   typename => "mirror",
# }
has "aka_name"                     => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "ccode",
#   typename => "mirror",
# }
has "ccode"                        => ( is => rw =>, );
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
#                 city => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "city",
#   typename => "mirror",
# }
has "city"                         => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "contact",
#   typename => "mirror",
# }
has "contact"                      => ( is => rw =>, );
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
#                 continent => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "continent",
#   typename => "mirror",
# }
has "continent"                    => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => {
#     fields => {
#                 analyzed => {
#                               analyzer => "standard",
#                               include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                               store => "yes",
#                               type => "string",
#                             },
#                 country  => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "country",
#   typename => "mirror",
# }
has "country"                      => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "dnsrr",
#   typename => "mirror",
# }
has "dnsrr"                        => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "freq",
#   typename => "mirror",
# }
has "freq"                         => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "ftp",
#   typename => "mirror",
# }
has "ftp"                          => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "http",
#   typename => "mirror",
# }
has "http"                         => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { format => "dateOptionalTime", store => "yes", type => "date" },
#   propertyname => "inceptdate",
#   typename => "mirror",
# }
has "inceptdate"                   => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { type => "geo_point" },
#   propertyname => "location",
#   typename => "mirror",
# }
has "location"                     => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "name",
#   typename => "mirror",
# }
has "name"                         => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "note",
#   typename => "mirror",
# }
has "note"                         => ( is => rw =>, );
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
#                 org => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "org",
#   typename => "mirror",
# }
has "org"                          => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => {
#     fields => {
#                 analyzed => {
#                               analyzer => "standard",
#                               include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                               store => "yes",
#                               type => "string",
#                             },
#                 region   => { index => "not_analyzed", store => "yes", type => "string" },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "region",
#   typename => "mirror",
# }
has "region"                       => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { format => "dateOptionalTime", store => "yes", type => "date" },
#   propertyname => "reitredate",
#   typename => "mirror",
# }
has "reitredate"                   => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "rsync",
#   typename => "mirror",
# }
has "rsync"                        => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "src",
#   typename => "mirror",
# }
has "src"                          => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "tz",
#   typename => "mirror",
# }
has "tz"                           => ( is => rw =>, );

no Moose;
__PACKAGE__->meta->make_immutable;

1;

