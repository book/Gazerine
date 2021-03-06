package Gazerine;

use Gazerine::Person;
use Gazerine::Gathering;

use Scalar::Util    qw< blessed >;
use Module::Runtime qw< use_module >;

use Moo;
use namespace::clean;

has datastore => (
    is  => 'ro',
    isa => sub {
        die "$_[0] does not Gazerine::Role::DataStore"
          if !eval { $_[0]->does('Gazerine::Role::DataStore') };
    },
    default  => sub { use_module( 'Gazerine::DataStore::Memory' )->new( gazerine => shift ) },
    required => 1,
    handles  => [
        qw<
          create_entity
          link linked_to
          >
    ],
);

1;
