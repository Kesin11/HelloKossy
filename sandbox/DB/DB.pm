package DB;
use strict;
use warnings;
use parent 'Teng';

package DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;

table {
    name 'Text';
    pk 'id';
    columns qw/id text/;
};

1;
