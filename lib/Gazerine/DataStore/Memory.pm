package Gazerine::DataStore::Memory;

use List::Util qw< max >;
use Scalar::Util qw< blessed >;

use Moo;
use namespace::clean;

with 'Gazerine::Role::DataStore';

my %storage;
my $name = 'memory1';

has 'name' => (
    is       => 'ro',
    default  => sub { $name++ },
    required => 1,
);

sub _next_id_ {
    return 1 + ( max( keys %{ $storage{ $_[0]->name }{ $_[1] } } ) // 0 );
}

sub create_entity {
    my $self = shift;
    my ( $class, $data ) = blessed $_[0] ? ( ref $_[0], $_[0]->as_hashref ) : @_;

    # compute the new id and store the data
    my $_id_ = $self->_next_id_($class);
    $storage{ $self->name }{$class}{$_id_} = { %$data, _id_ => $_id_ };

    # return a new object
    return $class->new( %$data, _id_ => $_id_ );
}

1;
