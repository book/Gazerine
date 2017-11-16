package Gazerine::Gathering;

use Moo;
use namespace::clean;

with 'Gazerine::Role::Entity';

sub kind { 'gathering' }

has name => (
    is       => 'ro',
    required => 1,
);

sub as_hashref {
    return { name => $_[0]->name };
}

sub register {
    my ( $self, @persons ) = @_;
    $self->gazerine->link( $self, $_ ) for @persons;
}

sub registered_persons {
    my ($self) = @_;
    return $self->gazerine->linked_to( $self => 'person' );
}

1;
