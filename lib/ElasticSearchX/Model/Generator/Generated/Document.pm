use strict;
use warnings;

package ElasticSearchX::Model::Generator::Generated::Document;
BEGIN {
  $ElasticSearchX::Model::Generator::Generated::Document::AUTHORITY = 'cpan:KENTNL';
}
{
  $ElasticSearchX::Model::Generator::Generated::Document::VERSION = '0.1.0';
}

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
  $INC{$mn} = 1;
  local ( $@, $! ) = ();
  ## no critic ( ProhibitStringyEval )
  eval $self->content eq '1' or do {
    die "Error loading generated content, $! $@";
  };
  die $@ if $@;
  return;
}
no Moo;

1;

__END__
=pod

=encoding utf-8

=head1 NAME

ElasticSearchX::Model::Generator::Generated::Document - A Generated ESX Document Model.

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

