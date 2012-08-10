use strict;
use warnings;

package ElasticSearchX::Model::Generator::Generated::Document;

# ABSTRACT: A Generated ESX Document Model.

use Moo;
use MooseX::Has::Sugar qw( rw required );

has 'path'    => rw, required;
has 'content' => rw, required;

sub write {
  my ( $self, %args ) = @_;
  my $file = Path::Class::File->new( $self->path );
  $file->dir->mkpath;
  $file->openw->print( $self->content );
  return;
}
no Moo;

1;
