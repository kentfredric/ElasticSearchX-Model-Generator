use strict;
use warnings;

package ElasticSearchX::Model::Generator::Generated::Document;

# ABSTRACT: A Generated ESX Document Model.

use Moo;
use MooseX::Has::Sugar qw( rw required );

has 'package' => rw, required;
has 'path'    => rw, required;
has 'content' => rw, required;

sub write {
  my ( $self, %args ) = @_;
  my $file = Path::Class::File->new( $self->path );
  $file->dir->mkpath;
  $file->openw->print( $self->content );
  return;
}

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
