package Gazerine::DataStore::Memory;

use List::Util qw< max >;
use Scalar::Util qw< blessed >;

use Moo;
use namespace::clean;

with 'Gazerine::Role::DataStore';

my %storage;
my $name = 'memory1';

has name => (
    is       => 'ro',
    default  => sub { $name++ },
    required => 1,
);

has store => (
    is       => 'ro',
    default  => sub { $storage{ $_[0]->name } //= {} },
    init_arg => undef,
);

sub _next_id_ {
    return 1 + ( max( keys %{ $_[0]->store->{ $_[1] } } ) // 0 );
}

sub create_entity {
    my $self = shift;
    my ( $kind, $data ) = blessed $_[0] ? ( $_[0]->kind, $_[0]->as_hashref ) : @_;
    my $class = "Gazerine::\u$kind";

    # compute the new id and store the data
    my $_id_ = $self->_next_id_($kind);
    $self->store->{$kind}{$_id_} = { %$data, _id_ => $_id_ };

    # return a new object
    return $class->new( %$data, _id_ => $_id_, gazerine => $self->gazerine );
}

1;
