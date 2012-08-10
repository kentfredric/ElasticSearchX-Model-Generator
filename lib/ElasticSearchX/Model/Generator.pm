use strict;
use warnings;

package ElasticSearchX::Model::Generator;

# ABSTRACT: Create a suite of ESX::Model classes from an existing mapping.

use Moo;

=head1 DESCRIPTION

B<ALPHA Code>: This class at present only contains code sufficient for very simple package generation for use in creating a model from an existing mapping for the purposes of search.


=head1 SYNOPSIS

  use ElasticSearchX::Model::Generator qw( generate_model );

  my $instance = generate_model(
    mapping_url => 'http://someserver:port/path/_mapping',
    generated_base_class => 'MyModel',
    base_dir => "../path/to/export/dir/"
  );

  for my $document ( $instance->documents ) {
    # Write the document to disk
    $document->write();
    # Alternatively, load the generated document into memory avoiding writing to disk
    $document->evaluate();
  }

=cut

=export generate_model

this is just a sugar syntax for ESX:M:G->new() you can elect to import to make your code slightly shorter.

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

=attr mapping_url

  rw, required

=attr base_dir

  rw, required

=cut

has mapping_url => rw, required;
has base_dir    => rw, required;

=attr generator_base_class

  rw, default: ElasticSearchX::Model::Generator

=attr generated_base_class

  rw, default: MyModel

=cut

has generator_base_class => rw, default => quote_sub(q{ 'ElasticSearchX::Model::Generator' });
has generated_base_class => rw, default => quote_sub(q{ 'MyModel' });

=attr document_generator_class

  lazy

=attr attribute_generator_class

  lazy

=attr typename_translator_class

  lazy

=cut

has document_generator_class  => is => lazy =>,;
has attribute_generator_class => is => lazy =>,;
has typename_translator_class => is => lazy =>,;

=attr document_generator

  lazy

=attr attribute_generator

  lazy

=attr typename_translator

  lazy

=cut

has document_generator  => is => lazy =>,;
has attribute_generator => is => lazy =>,;
has typename_translator => is => lazy =>,;

=p_attr _mapping_content

  lazy

=p_attr _ua

  lazy

=p_attr _mapping_data

  lazy

=cut

has _mapping_content => is => lazy =>,;
has _ua              => is => lazy =>,;
has _mapping_data    => is => lazy =>,;

=p_method _build__ua

returns an C<HTTP::Tiny> instance.

=cut

sub _build__ua {
  require HTTP::Tiny;
  return HTTP::Tiny->new();
}

=p_method _build_document_generator_class

  generator_base_class + '::DocumentGenerator'

=cut

sub _build_document_generator_class {
  my $self = shift;
  return $self->generator_base_class . '::DocumentGenerator';
}

=p_method _build_document_generator

returns an instance of C<$document_generator_class>

=cut

sub _build_document_generator {
  my $self = shift;
  require Module::Runtime;
  return Module::Runtime::use_module( $self->document_generator_class )->new( generator_base => $self, );
}

=p_method _build_attribute_generator_class

  generator_base_class + '::AttributeGenerator'

=cut

sub _build_attribute_generator_class {
  my $self = shift;
  return $self->generator_base_class . '::AttributeGenerator';
}

=p_method _build_attribute_generator

returns an instance of C<$attribute_generator_class>

=cut

sub _build_attribute_generator {
  my $self = shift;
  require Module::Runtime;
  return Module::Runtime::use_module( $self->attribute_generator_class )->new( generator_base => $self );
}

=p_method _build_typename_translator_class

  generator_base_class + '::TypenameTranslator'

=cut

sub _build_typename_translator_class {
  my $self = shift;
  return $self->generator_base_class . '::TypenameTranslator';
}

=p_method _build_typename_translator

returns an instance of C<$typename_translator_class>

=cut

sub _build_typename_translator {
  my $self = shift;
  require Module::Runtime;
  return Module::Runtime::use_module( $self->typename_translator_class )->new( generator_base => $self );
}

=p_method _build__mapping_content

returns the content of the url at C<mapping_url>

=cut

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

=p_method _build__mapping_data

returns the decoded data from JSON stored in C<_mapping_content>

=cut

sub _build__mapping_data {
  my $self    = shift;
  my $content = $self->_mapping_content;
  require JSON;
  return JSON->new()->utf8(1)->decode($content);
}

=method index_names

  @names = $esmg->index_names

returns the names of all indices specified in the C<_mapping>

=cut

## no critic ( RequireArgUnpacking ProhibitBuiltinHomonyms )
sub index_names {
  return keys %{ $_[0]->_mapping_data };
}

=method index

  $data = $esmg->index('') # If indices are not in the dataset
  $data = $esmg->index('cpan_v1') # if indices are in the dataset

Returns the dataset nested under the specified index.

=cut

sub index {
  if ( $_[1] eq q{} ) {
    return $_[0]->_mapping_data;
  }
  return $_[0]->_mapping_data->{ $_[1] };
}

=method type_names

  @names = $esmg->type_names( $index )
  @names = $esmg->type_names('')  # return all types defined in an index-free dataset.
  @names = $esmg->type_names('cpan_v1') # return all types in the cpan_v1 index.

=cut

sub type_names {
  my ( $self, $index ) = @_;
  return keys %{ $self->index($index) };
}

=method type

  $data = $esmg->type( $index, $type )
  $data = $esmg->type( '', 'File' )    # get type 'File' from an index-free dataset
  $data = $esmg->type( 'cpan_v1', 'File' )    # get type 'File' from the cpan_v1 index

=cut

sub type {
  my ( $self, $index, $type ) = @_;
  return $self->index($index)->{$type};
}

=method property_names

  @names = $esmg->property_names( $index, $type )

=cut

sub property_names {
  my ( $self, $index, $type ) = @_;
  return keys %{ $self->properties( $index, $type ) };
}

=method properties

  $properties = $esmg->properties( $index, $type )

=cut

sub properties {
  my ( $self, $index, $type ) = @_;
  return $self->type( $index, $type )->{properties};
}

=method property

  $property = $esmg->property( $index, $type, $propertyname )

=cut

sub property {
  my ( $self, $index, $type, $property ) = @_;
  return $self->properties( $index, $type )->{$property};
}

=method documents

  @documents = $esmg->documents(); # all documents for all indices
  @documents = $esmg->documents('cpan_v1'); # all documents for cpan_v1
  @documents = $esmg->documents(''); # all documents for an index-free dataset.

=cut

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
