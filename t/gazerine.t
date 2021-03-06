use strict;
use warnings;
use Test::More;

use Gazerine;

my $gaz = Gazerine->new;

# persons
my $p1 = $gaz->create_entity( person => { name => 'Barbapapa' } );
isa_ok $p1, 'Gazerine::Person';
is $p1->kind, 'person', 'person1 is a person';
is $p1->name, 'Barbapapa', 'person1 is named Barbapapa';
ok eval { $p1->_id_ }, 'person has an _id_';
is $p1->gazerine, $gaz, 'person points back to its creator';

my $p2 = Gazerine::Person->new( name => 'Barbapapa' );
isa_ok $p2, 'Gazerine::Person';
is $p2->kind, 'person', 'person2 is a person';
is $p2->_id_, undef, 'newly instantiated person has no id';

$p2 = $gaz->create_entity($p2);
isa_ok $p2, 'Gazerine::Person';
is $p2->name, 'Barbapapa', 'person2 is named Barbapapa';
ok eval { $p2->_id_ }, 'person has an _id_';

isnt $p1->_id_, $p2->_id_, 'different persons have different ids';

# gatherings
my $g1 = $gaz->create_entity( gathering => { name => 'My Conf' } );
isa_ok $g1, 'Gazerine::Gathering';
is $g1->kind, 'gathering', 'gathering1 is a gathering';
is $g1->name, 'My Conf', 'gathering1 is named My Conf';
ok eval { $g1->_id_ }, 'gathering has an _id_';


# registration to a gathering
is $g1->registered_persons, 0, "No one's registered yet";
$g1->register( $p1 );
is $g1->registered_persons, 1, "One person did register";

done_testing;
