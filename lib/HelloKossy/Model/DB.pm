package HelloKossy::Model::DB;
use parent 'Teng';

package HelloKossy::Model::DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;

table {
    name 'todos';
    pk 'id';
    columns qw/id name created_at updated_at comment/;
};

1;
