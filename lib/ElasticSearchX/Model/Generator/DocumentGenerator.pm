use strict;
use warnings;

package ElasticSearchX::Model::Generator::DocumentGenerator;
BEGIN {
  $ElasticSearchX::Model::Generator::DocumentGenerator::AUTHORITY = 'cpan:KENTNL';
}
{
  $ElasticSearchX::Model::Generator::DocumentGenerator::VERSION = '0.1.0';
}

# ABSTRACT:

use Moo;
use Data::Dump qw( pp );
use MooseX::Has::Sugar qw( rw required weak_ref );

has 'generator_base' => rw, required, weak_ref, handles => [qw( attribute_generator typename_translator )];

my $document_template = <<'EOF';
package %s;
use strict;
use warnings FATAL => 'all';
use Moose;
use ElasticSearchX::Model::Document;

%s

no Moose;
__PACKAGE__->meta->make_immutable;

1;

EOF

sub generate {
  my ( $self, %args ) = @_;
  my $class = $self->typename_translator->translate_to_package( typename => $args{typename} );
  my $path = $self->typename_translator->translate_to_path( typename => $args{typename} );
  my @attributes;
  for my $property_name ( sort { $a cmp $b } $self->generator_base->property_names( $args{index}, $args{typename} ) ) {
    my $property = $self->generator_base->property( $args{index}, $args{typename}, $property_name );
    push @attributes, $self->attribute_generator->generate(
      index        => $args{index},
      typename     => $args{typename},
      propertyname => $property_name,
      propertydata => $property,
    );
  }

  require ElasticSearchX::Model::Generator::Generated::Document;
  return ElasticSearchX::Model::Generator::Generated::Document->new(
    package => $class,
    path    => $path,
    content => ( sprintf $document_template, $class, join qq{\n}, map { $_->content } @attributes ),
  );
}

no Moo;

1;

__END__
=pod

=encoding utf-8

=head1 NAME

ElasticSearchX::Model::Generator::DocumentGenerator - use Moo;

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

