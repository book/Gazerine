package Gazerine::Gathering;

use Moo;
use namespace::clean;

with 'Gazerine::Role::Entity';

has name => (
    is       => 'ro',
    required => 1,
);

sub as_hashref {
    return { name => $_[0]->name };
}

1;
