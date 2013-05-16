use strict;
use warnings;

package ElasticSearchX::Model::Generator::AttributeGenerator;

# ABSTRACT: Generator that emits 'has' declarations for type properties.

use 5.10.0;
use Moo;
use Data::Dump qw( pp );
use MooseX::Has::Sugar qw( rw required weak_ref );

=attr generator_base

  rw, required, weak_ref

=cut

has 'generator_base' => rw, required, weak_ref, handles => [qw( document_generator typename_translator )];

=func expand_type

  %attr = ( %attr, expand_type( $type ) );
  %attr = ( %attr, expand_type( 'boolean' ) );

=cut

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

=method fill_property_template

  $string = $object->fill_property_template( $property_name, $property_value )

  my $data = $object->fill_property_template( foo => 'bar' );
  # $data == "    foo                         => bar,\n"
  my $data = $object->fill_property_template(quote( 'foo' ) => quote( 'bar' ));
  # $data == "    \"foo\"                       => \"bar\",\n"

=cut

=p_method _property_template_string

=cut

sub _property_template_string {
  return state $property_template = qq{    %-30s => %s,\n};
}

sub fill_property_template {
  my ( $self, @args ) = @_;
  return sprintf $self->_property_template_string, $args[0], $args[1];
}

sub _s_quote {
  my ( $self, $var ) = @_;
  my $back   = chr(0x5C);
  my $escape = chr(0x5C) . chr(0x27);
  $escape = '[' . $escape . ']';
  $var =~ s{($escape)}{ $back . $1 }gex;
  return q{'} . $var . q{'};
}

=method fill_attribute_template

  $string = $object->fill_attribute_template( $attribute_name, $attribute_properties_definition )

  my $data = $object->fill_attribute_template( foo => '    is => rw =>, ' );
  # $data ==
  # has "foo"              => (
  #     is => rw =>,
  # );

=cut

=p_method _attribute_template_string

=cut

sub _attribute_template_string {
  return state $attribute_template = qq{has %-30s => (\n%s\n);};
}

sub fill_attribute_template {
  my ( $self, @args ) = @_;
  return sprintf $self->_attribute_template_string, $self->_s_quote( $args[0] ), $args[1];

}

=func hash_to_proplist

  $string = hash_to_proplist( %hash )

  my $data = hash_to_proplist(
     is => rw =>,
     required => 1,
     foo => undef,
  );
  # $data = <<'EOF'
  # "is" => "rw",
  # "required" => "1",
  # "foo" => undef,
  # EOF

=cut

sub hash_to_proplist {
  my ( $self, %hash ) = @_;
  my $propdata = join q{}, map {
    defined $hash{$_}
      ? $self->fill_property_template( $self->_s_quote($_), $self->_s_quote( $hash{$_} ) )
      : $self->fill_property_template( $self->_s_quote($_), 'undef' )
  } sort keys %hash;
  chomp $propdata;
  return $propdata;
}

=p_method _inflate_attribute

    my $attr = $self->_inflate_attribute(
        prefix => $dump_comment,
        propertyname => "name of property",
        properties => \%cleaned_properties_for_has
        original_definition => \%original_args_to_generate
    );

=cut

sub _inflate_attribute {
  my ( $self, %config ) = @_;
  my $content = $config{prefix};
  $content .= $self->fill_attribute_template( $config{propertyname}, $self->hash_to_proplist( %{ $config{properties} } ) );
  require ElasticSearchX::Model::Generator::Generated::Attribute;
  return ElasticSearchX::Model::Generator::Generated::Attribute->new( content => $content );
}

=p_method _cleanup_properties

    %cleaned_has_props = $self->_cleanup_properties(%source_props)
=cut

sub _cleanup_properties {
  my ( $self, %properties_in ) = @_;

  my %properties = ();

  my $passthrough = sub {
    my $name = shift;
    my $d    = $properties_in{$name};
    $properties{$name} = $properties_in{$name};
  };
  my $bool_passthrough = sub {
    my $name = shift;
    my $d    = $properties_in{$name};
    require Scalar::Util;
    if ( Scalar::Util::blessed($d) and Scalar::Util::blessed($d) eq 'JSON::XS::Boolean' ) {
      $properties{$name} = ( $d ? 1 : undef );
      return;
    }
    if ( $d eq 'true' or $d eq 'false' ) {
      $properties{$name} = ( $d eq 'true' ? 1 : undef );
      return;
    }
    $properties{$name} = $properties_in{$name};
  };
  my $type_passthrough = sub {
    my $name = shift;
    my $d    = $properties_in{$name};
    %properties = ( %properties, expand_type($d) );
  };
  my %passthrough_fields = (
    store             => $passthrough,
    boost             => $passthrough,
    index             => $passthrough,
    dynamic           => $bool_passthrough,
    analyzer          => $bool_passthrough,
    include_in_all    => $passthrough,
    include_in_parent => $passthrough,
    include_in_root   => $bool_passthrough,
    term_vector       => $passthrough,
    not_analyzed      => $passthrough,
    type              => $type_passthrough,
  );
  for my $propname ( keys %passthrough_fields ) {
    next unless exists $properties_in{$propname};
    $passthrough_fields{$propname}->($propname);
  }
  return %properties;

}

=method generate

  $generated_attribute = $attributegenerator->generate(
    propertydata => ... Property definition from JSON ...
    propertyname => ... Property name from JSON ...
    index        => ... Name of current index ...
    typename     => ... Name of the type we're generating ...
  );

  $generated_attribute->isa(ESX:M:G:Generated::Attribute);

=cut

sub generate {
  my ( $self, %args ) = @_;

  my $definition = pp( \%args );
  $definition =~ s/^/# /gsm;

  return $self->_inflate_attribute(
    prefix              => "$definition\n",
    propertyname        => $args{propertyname},
    original_definition => \%args,
    properties          => {
      is => 'rw',
      $self->_cleanup_properties( %{ $args{propertydata} } )
    }
  );
}

no Moo;
1;
