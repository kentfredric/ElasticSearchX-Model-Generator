use strict;
use warnings;

use Test::More tests => 1;                      # last test to print

use FindBin;
use ElasticSearchX::Model::Generator qw( generate_model );

my $instance = generate_model( 
	mapping_url => 'http://api.metacpan.org/v0/_mapping',
	base_dir => "$FindBin::Bin/gen/",
);
use Data::Dump qw( pp );
for my $document ( $instance->documents() ) {
    *STDERR->print("Writing " . $document->path  . "\n");
    $document->write;
}

