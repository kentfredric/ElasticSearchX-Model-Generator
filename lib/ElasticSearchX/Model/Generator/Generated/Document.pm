use strict;
use warnings;

package ElasticSearchX::Model::Generator::Generated::Document;

# ABSTRACT: A Generated C<ESX> Document Model.

use Moo;
use Path::Tiny ();
use MooseX::Has::Sugar qw( rw required );

=attr package

  rw, required

=attr path

  rw, required

=attr content

  rw, required

=cut

has 'package' => rw, required;
has 'path'    => rw, required;
has 'content' => rw, required;

=method write

  $document->write();
  # $document->path is filled with $document->content

=cut

sub write {
  my ( $self, %args ) = @_;
  my $file = Path::Tiny::path( $self->path );
  $file->parent->mkpath;
  $file->openw->print( $self->content );
  return;
}

=method evaluate

  $document->evaluate();
  my $instance = $document->package->new(
    # magical =D
  );

=cut

sub evaluate {
  my ( $self, %args ) = @_;
  require Module::Runtime;
  my $mn = Module::Runtime::module_notional_filename( $self->package );
  ## no critic (RequireLocalizedPunctuationVars)
  $INC{$mn} = 1;
  local ( $@, $! ) = ();
  ## no critic ( ProhibitStringyEval )
  if ( not eval $self->content ) {
    require Carp;
    Carp::croak( sprintf 'content for %s did not load: %s %s', $self->package, $@, $! );
  }
  ## no critic ( RequireCarping )
  die $@ if $@;
  return;
}
no Moo;

1;
