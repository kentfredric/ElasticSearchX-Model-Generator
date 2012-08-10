use strict;
use warnings;

package ElasticSearchX::Model::Generator::AttributeGenerator;

# ABSTRACT:

use 5.10.0;
use Moo;
use Data::Dump qw( pp quote );
use MooseX::Has::Sugar qw( rw required weak_ref );

has 'generator_base' => rw, required, weak_ref, handles => [qw( document_generator typename_translator )];

sub expand_type {
  my ($type) = shift;
  state $known_types = {
    string  => 1,
    float   => 1,
    integer => 1,
    boolean => 1,
  };
  state $need_info_types = {
    date        => 1,
    geo_point   => 1,
    nested      => 1,
    multi_field => 1,
  };
  if ( exists $known_types->{$type} ) {
    return ( type => $type );
  }
  if ( exists $need_info_types->{$type} ) {

    #    require Carp;
    #    Carp::carp("Dont understand $type");
    return ();
  }
  else {
    require Carp;
    Carp::carp("Dont understand $type");
    return ();
  }
}

sub fill_property_template {
  my (@args) = @_;
  state $property_template = <<'PROP';
    %-30s => %s,
PROP
  return sprintf $property_template, $args[0], $args[1];
}

sub fill_attribute_template {
  my (@args) = @_;

  state $attribute_template = do {
    my $x = <<'EOF';
has %-30s => (
%s
);
EOF
    chomp $x;
    $x;
  };
  return sprintf $attribute_template, quote( $args[0] ), $args[1];

}

sub hash_to_proplist {
  my (%hash) = @_;
  my $propdata = join q{}, map {
    defined $hash{$_}
      ? fill_property_template( quote($_), quote( $hash{$_} ) )
      : fill_property_template( quote($_), 'undef' )
  } sort keys %hash;
  chomp $propdata;
  return $propdata;
}

sub generate {
  my ( $self, %args ) = @_;

  my $definition = pp( \%args );
  $definition =~ s/^/# /gsm;

  my $prefix = q{};

  $prefix .= "$definition\n";
  state $passthrough_fields = {
    store             => 1,
    boost             => 1,
    index             => 1,
    dynamic           => 'Bool',
    analyzer          => 1,
    include_in_all    => 1,
    include_in_parent => 1,
    include_in_root   => 'Bool',
    term_vector       => 1,
    not_analyzed      => 1,
  };

  my %properties = ( is => rw =>, );

  for my $propname ( keys %{$passthrough_fields} ) {
    next unless exists $args{propertydata}->{$propname};
    my $d = $args{propertydata}->{$propname};

    if ( $passthrough_fields->{$propname} eq '1' ) {
      $properties{$propname} = $d;
      next;
    }
    if ( $passthrough_fields->{$propname} eq 'Bool' ) {
      require Scalar::Util;
      if ( Scalar::Util::blessed($d) and Scalar::Util::blessed($d) eq 'JSON::XS::Boolean' ) {
        $properties{$propname} = ( $d ? 1 : undef );
        next;
      }
      if ( $d eq 'true' or $d eq 'false' ) {
        $properties{$propname} = ( $d eq 'true' ? 1 : undef );
        next;
      }
    }
    $properties{$propname} = $d;
  }

  %properties = ( %properties, expand_type( $args{propertydata}->{type} ) ) if exists $args{propertydata}->{type};

  require ElasticSearchX::Model::Generator::Generated::Attribute;
  return ElasticSearchX::Model::Generator::Generated::Attribute->new(
    content => $prefix . fill_attribute_template( $args{propertyname}, hash_to_proplist(%properties) ) );
}

no Moo;
1;
