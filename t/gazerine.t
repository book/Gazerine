use strict;
use warnings;
use Test::More;

use Gazerine;

my $gaz = Gazerine->new;

# persons
my $p1 = $gaz->create_entity( 'Gazerine::Person', { name => 'Barbapapa' } );
isa_ok $p1, 'Gazerine::Person';
is $p1->name, 'Barbapapa', 'person1 is named Barbapapa';
ok eval { $p1->_id_ }, 'person has an _id_';

my $p2 = Gazerine::Person->new( name => 'Barbapapa' );
is $p2->_id_, undef, 'newly instantiated person has no id';

$p2 = $gaz->create_entity($p2);
isa_ok $p2, 'Gazerine::Person';
is $p2->name, 'Barbapapa', 'person2 is named Barbapapa';
ok eval { $p2->_id_ }, 'person has an _id_';

isnt $p1->_id_, $p2->_id_, 'different persons have different ids';

done_testing;
