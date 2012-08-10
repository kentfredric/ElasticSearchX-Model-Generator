package MyModel::Release;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => {
#     fields => {
#                 abstract => { index => "not_analyzed", store => "yes", type => "string" },
#                 analyzed => {
#                               analyzer => "standard",
#                               include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                               store => "yes",
#                               type => "string",
#                             },
#               },
#     type   => "multi_field",
#   },
#   propertyname => "abstract",
#   typename => "release",
# }
has "abstract"                     => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "archive",
#   typename => "release",
# }
has "archive"                      => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "author",
#   typename => "release",
# }
has "author"                       => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "boolean" },
#   propertyname => "authorized",
#   typename => "release",
# }
has "authorized"                   => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { format => "dateOptionalTime", store => "yes", type => "date" },
#   propertyname => "date",
#   typename => "release",
# }
has "date"                         => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic => "false",
#     include_in_root => bless(do{\(my $o = 1)}, "JSON::XS::Boolean"),
#     properties => {
#       module => { index => "not_analyzed", store => "yes", type => "string" },
#       phase => { index => "not_analyzed", store => "yes", type => "string" },
#       relationship => { index => "not_analyzed", store => "yes", type => "string" },
#       version => { index => "not_analyzed", store => "yes", type => "string" },
#       version_numified => { store => "yes", type => "float" },
#     },
#     type => "nested",
#   },
#   propertyname => "dependency",
#   typename => "release",
# }
has "dependency"                   => ( is => rw =>, );
# do {
#   my $a = {
#     index => "cpan_v1",
#     propertydata => {
#       fields => {
#                   analyzed     => {
#                                     analyzer => "standard",
#                                     include_in_all => bless(do{\(my $o = 0)}, "JSON::XS::Boolean"),
#                                     store => "yes",
#                                     type => "string",
#                                   },
#                   camelcase    => {
#                                     analyzer => "camelcase",
#                                     include_in_all => 'fix',
#                                     store => "yes",
#                                     type => "string",
#                                   },
#                   distribution => { index => "not_analyzed", store => "yes", type => "string" },
#                   lowercase    => {
#                                     analyzer => "lowercase",
#                                     include_in_all => 'fix',
#                                     store => "yes",
#                                     type => "string",
#                                   },
#                 },
#       type   => "multi_field",
#     },
#     propertyname => "distribution",
#     typename => "release",
#   };
#   $a->{propertydata}{fields}{camelcase}{include_in_all} = \${$a->{propertydata}{fields}{analyzed}{include_in_all}};
#   $a->{propertydata}{fields}{lowercase}{include_in_all} = \${$a->{propertydata}{fields}{analyzed}{include_in_all}};
#   $a;
# }
has "distribution"                 => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "download_url",
#   typename => "release",
# }
has "download_url"                 => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "boolean" },
#   propertyname => "first",
#   typename => "release",
# }
has "first"                        => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "id",
#   typename => "release",
# }
has "id"                           => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "license",
#   typename => "release",
# }
has "license"                      => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "maturity",
#   typename => "release",
# }
has "maturity"                     => ( is => rw =>, );
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
#     typename => "release",
#   };
#   $a->{propertydata}{fields}{camelcase}{include_in_all} = \${$a->{propertydata}{fields}{analyzed}{include_in_all}};
#   $a->{propertydata}{fields}{lowercase}{include_in_all} = \${$a->{propertydata}{fields}{analyzed}{include_in_all}};
#   $a;
# }
has "name"                         => ( is => rw =>, );
# do {
#   my $a = {
#     index => "cpan_v1",
#     propertydata => {
#       dynamic => "true",
#       include_in_root => bless(do{\(my $o = 1)}, "JSON::XS::Boolean"),
#       properties => {
#         bugtracker => {
#                         dynamic => "true",
#                         include_in_root => 'fix',
#                         properties => {
#                           mailto => { index => "not_analyzed", store => "yes", type => "string" },
#                           web => { index => "not_analyzed", store => "yes", type => "string" },
#                           x_url => { type => "string" },
#                         },
#                         type => "nested",
#                       },
#         homepage   => { index => "not_analyzed", store => "yes", type => "string" },
#         license    => { index => "not_analyzed", store => "yes", type => "string" },
#         repository => {
#                         dynamic => "true",
#                         include_in_root => 'fix',
#                         properties => {
#                           type => { index => "not_analyzed", store => "yes", type => "string" },
#                           url  => { index => "not_analyzed", store => "yes", type => "string" },
#                           web  => { index => "not_analyzed", store => "yes", type => "string" },
#                         },
#                         type => "nested",
#                       },
#       },
#       type => "nested",
#     },
#     propertyname => "resources",
#     typename => "release",
#   };
#   $a->{propertydata}{properties}{bugtracker}{include_in_root} = \${$a->{propertydata}{include_in_root}};
#   $a->{propertydata}{properties}{repository}{include_in_root} = \${$a->{propertydata}{include_in_root}};
#   $a;
# }
has "resources"                    => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "true",
#     properties => {
#                     gid   => { store => "yes", type => "integer" },
#                     mode  => { store => "yes", type => "integer" },
#                     mtime => { store => "yes", type => "integer" },
#                     size  => { store => "yes", type => "integer" },
#                     uid   => { store => "yes", type => "integer" },
#                   },
#   },
#   propertyname => "stat",
#   typename => "release",
# }
has "stat"                         => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "status",
#   typename => "release",
# }
has "status"                       => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => {
#     dynamic    => "true",
#     properties => {
#                     fail => { store => "yes", type => "integer" },
#                     na => { store => "yes", type => "integer" },
#                     pass => { store => "yes", type => "integer" },
#                     unknown => { store => "yes", type => "integer" },
#                   },
#   },
#   propertyname => "tests",
#   typename => "release",
# }
has "tests"                        => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "version",
#   typename => "release",
# }
has "version"                      => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "float" },
#   propertyname => "version_numified",
#   typename => "release",
# }
has "version_numified"             => ( is => rw =>, );

no Moose;
__PACKAGE__->meta->make_immutable;

1;

