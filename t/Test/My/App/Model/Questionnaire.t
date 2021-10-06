use utf8;
package Test::My::App::Model::Questionnaire;
use base 'Test::Class';
use Path::Tiny 'path';
use FindBin '$Bin';
use Test2::V0 -target => 'My::App::Model::Questionnaire';
use Test2::Tools::Explain;

# helper method to instantiate a database
sub make_database {
    my ( $test, @files ) = ( shift, @_ );

    require DBI;
    my $dbh = 'DBI'->connect( 'dbi:SQLite:dbname=:memory:', undef, undef, {
        AutoCommit => 1,
        RaiseError => 1,
    } );

    my $root = path( $Bin );
    $root = $root->parent for split /::/, __PACKAGE__;
    for my $filename ( @files ) {
        my $sqlfile = $root->child( 'sql' )->child( $filename );
        # this is horrible, but...
        $dbh->do( $_ ) for split /;/, $sqlfile->slurp;
    }

    return $dbh;
}

sub test_from_hashref : Test(1) {
    my ( $test ) = ( shift );

    my $object = $CLASS->from_hashref( {
        title        => 'Test Questionnaire',
        is_published => 1,
        questions    => [
            'What is your name?',
            {
                question_type => 'single_option',
                question_text => 'What is your favourite colour?',
                options       => [
                    { option_text => 'Red' },
                    { option_text => 'Blue' },
                    'Yellow',
                    { option_text => 'Green' },
                ],
            },
            {
                question_type => 'multi_option',
                question_text => 'What pets do you own?',
                options       => [qw( Dog Cat Fish Other )],
            },
        ],
    } );

    is(
        $object,
        object {
            prop 'isa'          => 'My::App::Model::Questionnaire';
            call 'title'        => string 'Test Questionnaire';
            call 'is_published' => bool !!1;
            call 'questions'    => array {
                item object {
                    prop 'isa'           => 'My::App::Model::Question::Text';
                    call 'question_text' => 'What is your name?';
                };
                item object {
                    prop 'isa'           => 'My::App::Model::Question::SingleOption';
                    call 'question_text' => 'What is your favourite colour?';
                    call 'options'       => array {
                        item object { call 'option_text' => 'Red'; };
                        item object { call 'option_text' => 'Blue'; };
                        item object { call 'option_text' => 'Yellow'; };
                        item object { call 'option_text' => 'Green'; };
                        end();
                    };
                };
                item object {
                    prop 'isa'           => 'My::App::Model::Question::MultiOption';
                    call 'question_text' => 'What pets do you own?';
                    call 'options'       => array {
                        item object { call 'option_text' => 'Dog'; };
                        item object { call 'option_text' => 'Cat'; };
                        item object { call 'option_text' => 'Fish'; };
                        item object { call 'option_text' => 'Other'; };
                        end();
                    };
                };
                end();
            };
        },
        'Correct object created from hashref',
    ) or diag explain( $object );
}

sub test_from_id : Test(1) {
    my ( $test ) = ( shift );

    require My::App::Schema;
    my $schema = 'My::App::Schema'->connect(
        sub { $test->make_database( 'schema.sql', 'sample-data.sql' ) },
    );

    my $object = $CLASS->from_id( $schema, 1 );

    is(
        $object,
        object {
            prop 'isa'          => 'My::App::Model::Questionnaire';
            call 'title'        => string 'Sample Questionnaire';
            call 'is_published' => bool !!1;
            call 'questions'    => array {
                item object {
                    prop 'isa'           => 'My::App::Model::Question::Text';
                    call 'question_text' => 'What is your name?';
                };
                item object {
                    prop 'isa'           => 'My::App::Model::Question::Text';
                    call 'question_text' => 'What is your age?';
                };
                item object {
                    prop 'isa'           => 'My::App::Model::Question::SingleOption';
                    call 'question_text' => 'What is your favourite colour?';
                    call 'options'       => array {
                        item object { call 'option_text' => 'Red'; };
                        item object { call 'option_text' => 'Blue'; };
                        item object { call 'option_text' => 'Yellow'; };
                        item object { call 'option_text' => 'Green'; };
                        end();
                    };
                };
                item object {
                    prop 'isa'           => 'My::App::Model::Question::MultiOption';
                    call 'question_text' => 'Do you own any pets?';
                    call 'options'       => array {
                        item object { call 'option_text' => 'Dog'; };
                        item object { call 'option_text' => 'Cat'; };
                        item object { call 'option_text' => 'Fish'; };
                        item object { call 'option_text' => 'Other'; };
                        end();
                    };
                };
                end();
            };
        },
        'Correct object created from hashref',
    ) or diag explain( $object );
}

sub test_summary_list : Test(1) {
    my ( $test ) = ( shift );

    require My::App::Schema;
    my $schema = 'My::App::Schema'->connect(
        sub { $test->make_database( 'schema.sql', 'sample-data.sql' ) },
    );

    my $summary = $CLASS->summary_list( $schema );
    is(
        $summary,
        [ { title => 'Sample Questionnaire', id => 1 } ],
        'summary_list works',
    );
}

__PACKAGE__->runtests unless caller;

1;
