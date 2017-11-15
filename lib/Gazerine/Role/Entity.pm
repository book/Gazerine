package Gazerine::Role::Entity;

use Moo::Role;
use namespace::clean;

requires
  'as_hashref',    # attributes to pass to new to restore the object
  'kind',          # short version of the class name
  ;

# internal id, coming from the storage layer
# should never ever be visible on the outside
has _id_ => (
    is => 'ro',
);

has gazerine => (
    is => 'ro',
);

1;
