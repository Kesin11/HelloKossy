use lib 'lib/HelloKossy';
use Model::DB;

sub init{
	my $teng = shift;
	print "Create TABLE todos\n";
	$teng->do(q{
		CREATE TABLE todos(
			id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
			name TEXT NOT NULL,
			created_at DATETIME,
			updated_at TIMESTAMP ON UPDATE current_timestamp,
			comment TEXT default NULL,
			parent_id INT default NULL,
			deadline DATETIME
		)
	});
}

print "DB initializing...\n";
my $teng = HelloKossy::Model::DB->new(
    +{connect_info => ['dbi:mysql:database=HelloKossy', 'hellokossy', 'dena']}
);
init($teng);
print "DB initialized...\n";

1;
