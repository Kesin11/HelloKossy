use strict;
use warnings;
use utf8;
use DB::DB;

my $dsn = 'dbi:mysql:database=HelloKossy';
my $user = 'hellokossy';
my $password = 'dena';

my $teng = DB->new({connect_info =>
        [$dsn, $user, $password]
    });

my $row = $teng->single('Text', {'id' => 1});
print $row->text;

$row = $teng->insert('Text' => {
    text => 'Tengから追加されたテキスト'
});

my $it = $teng->search('Text');
while (my $row = $it->next) {
    print $row->text, "\n";
}

print "---------\n";

my @rows = $teng->search('Text');
for my $row (@rows){
    print $row->text, "\n";
}

1;
