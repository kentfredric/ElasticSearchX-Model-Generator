package MyModel::Dependency;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "module",
#   typename => "dependency",
# }
has "module"                       => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "phase",
#   typename => "dependency",
# }
has "phase"                        => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "relationship",
#   typename => "dependency",
# }
has "relationship"                 => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { index => "not_analyzed", store => "yes", type => "string" },
#   propertyname => "version",
#   typename => "dependency",
# }
has "version"                      => ( is => rw =>, );
# {
#   index => "cpan_v1",
#   propertydata => { store => "yes", type => "float" },
#   propertyname => "version_numified",
#   typename => "dependency",
# }
has "version_numified"             => ( is => rw =>, );

no Moose;
__PACKAGE__->meta->make_immutable;

1;

