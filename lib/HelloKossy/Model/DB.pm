package HelloKossy::Model::DB;
use parent 'Teng';

package HelloKossy::Model::DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;
use DateTime::Format::MySQL;

table {
    name 'todos';
    pk 'id';
    columns qw/id name created_at updated_at comment parent_id deadline/;

    inflate qr/_at$/ => sub{
        DateTime::Format::MySQL->parse_datetime(shift);
    };

    deflate qr/_at$/ => sub{
        DateTime::Format::MySQL->format_datetime(shift);
    };
};

1;
