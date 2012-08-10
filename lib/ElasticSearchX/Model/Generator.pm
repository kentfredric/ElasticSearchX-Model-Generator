use strict;
use warnings;

package ElasticSearchX::Model::Generator;

# ABSTRACT: Create a suite of ESX::Model classes from an existing mapping.

use Moo;

=head1 DESCRIPTION

B<ALPHA Code>: This class at present only contains code sufficient for very simple package generation for use in creating a model from an existing mapping for the purposes of search. 


=head1 SYNOPSIS

	use ElasticSearchX::Model::Generator qw( generate_model );


	generate_model( 
		mapping_url => 'http://someserver:port/path/_mapping',
		generated_base_class => 'MyModel',
		base_dir => "../path/to/export/dir/"
	);

=cut

use Sub::Exporter -setup => {
  exports => [
    generate_model => sub {
      my $class = __PACKAGE__;
      my $call  = $class->can('new');
      return sub {
        unshift @_, $class;
        goto $call;
      };
    },
  ]
};
use MooseX::Has::Sugar qw( rw ro required );
use Sub::Quote qw( quote_sub );

has mapping_url => rw, required;
has base_dir    => rw, required;

has generator_base_class => rw, default => quote_sub(q{ 'ElasticSearchX::Model::Generator' });
has generated_base_class => rw, default => quote_sub(q{ 'MyModel' });

has document_generator_class  => is => lazy =>,;
has attribute_generator_class => is => lazy =>,;
has typename_translator_class => is => lazy =>,;

has document_generator  => is => lazy =>,;
has attribute_generator => is => lazy =>,;
has typename_translator => is => lazy =>,;

has _mapping_content => is => lazy =>,;
has _ua              => is => lazy =>,;
has _mapping_data    => is => lazy =>,;

sub _build__ua {
  require HTTP::Tiny;
  return HTTP::Tiny->new();
}

sub _build_document_generator_class {
  my $self = shift;
  return $self->generator_base_class . '::DocumentGenerator';
}

sub _build_document_generator {
  my $self = shift;
  require Module::Runtime;
  return Module::Runtime::use_module( $self->document_generator_class )->new( generator_base => $self, );
}

sub _build_attribute_generator_class {
  my $self = shift;
  return $self->generator_base_class . '::AttributeGenerator';
}

sub _build_attribute_generator {
  my $self = shift;
  require Module::Runtime;
  return Module::Runtime::use_module( $self->attribute_generator_class )->new( generator_base => $self );
}

sub _build_typename_translator_class {
  my $self = shift;
  return $self->generator_base_class . '::TypenameTranslator';
}

sub _build_typename_translator {
  my $self = shift;
  require Module::Runtime;
  return Module::Runtime::use_module( $self->typename_translator_class )->new( generator_base => $self );
}

sub _build__mapping_content {
  my $self     = shift;
  my $response = $self->_ua->get( $self->mapping_url );
  if ( not $response->{success} ) {
    require Carp;
    Carp::confess( sprintf qq[Failed to fetch mapping:\n\tstatus=%s\n\treason=%s\n], $response->{status}, $response->{reason} );
  }
  if ( length $response->{content} != $response->{headers}->{'content-length'} ) {
    require Carp;
    Carp::confess(
      sprintf qq[Content length did not match expected length, _mapping failed to fetch completely.\n\tgot=%s\n\texpected%s\n],
      length $response->{content},
      $response->{headers}->{'Content-Length'}
    );
  }
  return $response->{content};
}

sub _build__mapping_data {
  my $self    = shift;
  my $content = $self->_mapping_content;
  require JSON;
  return JSON->new()->utf8(1)->decode($content);
}
## no critic ( RequireArgUnpacking ProhibitBuiltinHomonyms )
sub index_names {
  return keys %{ $_[0]->_mapping_data };
}

sub index {
  if ( $_[1] eq q{} ) {
    return $_[0]->_mapping_data;
  }
  return $_[0]->_mapping_data->{ $_[1] };
}

sub type_names {
  my ( $self, $index ) = @_;
  return keys %{ $self->index($index) };
}

sub type {
  my ( $self, $index, $type ) = @_;
  return $self->index($index)->{$type};
}

sub property_names {
  my ( $self, $index, $type ) = @_;
  return keys %{ $self->properties( $index, $type ) };
}

sub properties {
  my ( $self, $index, $type ) = @_;
  return $self->type( $index, $type )->{properties};
}

sub property {
  my ( $self, $index, $type, $property ) = @_;
  return $self->properties( $index, $type )->{$property};
}

sub documents {
  my ( $self, @indices ) = @_;
  if ( not @indices ) {
    @indices = $self->index_names;
  }
  my @documents;
  for my $index (@indices) {
    for my $typename ( $self->type_names($index) ) {
      push @documents, $self->document_generator->generate(
        index    => $index,
        typename => $typename,
        typedata => $self->type( $index, $typename ),
      );
    }
  }
  return @documents;
}

no Moo;

1;
