#!/usr/bin/env perl
use v5.26;
use warnings;
use utf8;
package t::unit::TPS::Questionnaire::Model::QuestionnaireAnswer;

use Test2::V0 -target => 'TPS::Questionnaire::Model::QuestionnaireAnswer';
use Test2::Tools::Explain;
use Test2::Tools::Spec;

use FindBin qw($Bin $Script);
use Path::Tiny qw(path);

use TPS::Questionnaire::Model::Questionnaire;

# Helper method to connect to a new in-memory database and load into it
# SQL from named files. Returns a dbh for the open database.
sub make_database {
    my @files = @_;

    require DBI;
    my $dbh = DBI->connect('dbi:SQLite:dbname=:memory:', undef, undef, {
        AutoCommit => 1,
        RaiseError => 1,
    });

    my $project_root = path($Bin, $Script)->parent(scalar(split /::/, __PACKAGE__));
    for my $filename (@files) {
        my $sqlfile = $project_root->child('sql', $filename);
        # this is horrible, but...
        $dbh->do($_) for split /;/, $sqlfile->slurp;
    }

    return $dbh;
}

sub schema_and_questionnaire {
    require TPS::Questionnaire::Schema;
    my $schema = TPS::Questionnaire::Schema->connect(
        sub { make_database('schema.sql', 'sample-data.sql') },
    );

    my $q = 'TPS::Questionnaire::Model::Questionnaire'->from_id($schema, 1);

    return ( $schema, $q );
}

tests from_hashref => sub {
    plan(1);

    my $object = $CLASS->from_hashref({
        user_id => 123,
        questionnaire_id => 1,
        answers => {
            1 => 41,
            2 => 'Toby',
            3 => 3,
            4 => [8],
        },
    });

    is(
        $object,
        object {
            prop 'isa' => 'TPS::Questionnaire::Model::QuestionnaireAnswer';
            call 'user_id' => number 123;
            call 'answered_at' => D();
            call 'questionnaire_id' => 1;
            call '_raw_answers' => {
                1 => 41,
                2 => 'Toby',
                3 => 3,
                4 => [8],
            };
        },
        'object constructed correctly',
    );
};

tests to_hashref => sub {
    plan(1);

    my $object = $CLASS->new(
        user_id => 123,
        questionnaire_id => 1,
        answers => {
            1 => 41,
            2 => 'Toby',
            3 => 3,
            4 => [8],
        },
    );

    is(
        $object->to_hashref,
        {
            user_id => 123,
            questionnaire_id => 1,
            answers => {
                1 => 41,
                2 => 'Toby',
                3 => 3,
                4 => [8],
            },
            answered_at => D(),
            id => undef,
        },
        'correct hashref',
    );
};

tests validate_answers => sub {
    plan(2);

    my ($schema, $q) = schema_and_questionnaire();

    my $answer = $CLASS->new(
        user_id => 123,
        questionnaire_id => 1,
        answers => {
            1 => 41,
            2 => 'Toby',
            3 => 3,
            4 => [8],
        },
    );
    is(
        [$answer->validate_answers($schema)],
        [],
        'good answer',
    );

    $answer = $CLASS->new(
        user_id => 123,
        questionnaire_id => 1,
        answers => {
            1 => 41,
            2 => 'Toby',
            3 => 3,
            4 => [8, 9],
        },
    );
    is(
        [$answer->validate_answers($schema)],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Answer 2 must be one of the given options; not custom text";
                call 'answer' => [8, 9];
                call 'question' => object {
                    call 'question_text' => 'Do you own any pets?';
                };
            }
        ],
        'bad answer',
    );
};

done_testing();

1;
