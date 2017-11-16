package Gazerine::Role::DataStore;

use Moo::Role;
use namespace::clean;

requires
  'create_entity',
  'link',
  ;

has gazerine => (
    is       => 'ro',
    required => 1,
);

1;
