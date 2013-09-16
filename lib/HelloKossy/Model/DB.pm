package HelloKossy::Model::DB;
use parent 'Teng';

package HelloKossy::Model::DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;

table {
    name 'Text';
    pk 'id';
    columns qw/id text/;
};

1;
