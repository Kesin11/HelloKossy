package HelloKossy::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use HelloKossy::Model::DB;
use Data::Dumper;

my $teng = HelloKossy::Model::DB->new(
    +{connect_info => ['dbi:mysql:database=HelloKossy', 'hellokossy', 'dena']}
);

filter 'set_title' => sub {
    my $app = shift;
    sub {
        my ( $self, $c )  = @_;
        $c->stash->{site_name} = __PACKAGE__;
        $app->($self,$c);
    }
};

get '/' => [qw/set_title/] => sub {
    my ( $self, $c )  = @_;
    my $it = $teng->search('todos');
    $c->render('index.tx', {text_it => $it});
};

post '/submit' => sub {
    my ( $self, $c )  = @_;
    my $result = $c->req->validator([
        'text' => {
            rule => [
                ['NOT_NULL','empty body'],
            ],
        }]);
    my $text = $result->valid->get('text');
    my $row = $teng->insert('todos' => {
            name => $text
    });
    $c->redirect($c->req->uri_for('/'));
};

get '/{id:[0-9]+}' => sub{
    my ( $self, $c ) = @_;
    my $row = $teng->single('todos', {"id" => $c->args->{id}});
    if ($row){
        $c->render('edit.tx', {row => $row});
    }
    else{
        $c->halt(404, "file not found");
    }
};

# kossyでformタグからput, deleteメソッドでアクセスできないようなので、仕方なくこのアクセスポイントにする
post '/update/{id:[0-9]+}' => sub{
    my ( $self, $c ) = @_;
    my $id = $c->args->{id};
    my $result = $c->req->validator([
        'text' => {
            rule => [
                ['NOT_NULL','empty body'],
            ],
        }]);
    my $text = $result->valid->get('text');
    my $record = $teng->update('todos', +{name => $text}, +{id => $id});
    $c->redirect($c->req->uri_for('/'));
};

get '/delete/{id:[0-9]+}' => sub{
    my ( $self, $c ) = @_;
    my $id = $c->args->{id};
    $teng->delete('todos', +{id => $id});
    $c->redirect($c->req->uri_for('/'));
};

get '/json' => sub {
    my ( $self, $c )  = @_;
    my $result = $c->req->validator([
        'q' => {
            default => 'Hello',
            rule => [
                [['CHOICE',qw/Hello Bye/],'Hello or Bye']
            ],
        }
    ]);
    $c->render_json({ greeting => $result->valid->get('q') });
};

1;
