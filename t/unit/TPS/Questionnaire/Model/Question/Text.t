#!/usr/bin/env perl
use v5.26;
use warnings;
use utf8;
package t::unit::TPS::Questionnaire::Model::Question::Text;

use Test2::V0 -target => 'TPS::Questionnaire::Model::Question::Text';
use Test2::Tools::Explain;
use Test2::Tools::Spec;

use FindBin qw($Bin $Script);
use Path::Tiny qw(path);

tests from_hashref => sub {
    plan(2);

    my $object = $CLASS->from_hashref({
        question_text => 'Foo?',
    });

    is(
        $object,
        object {
            prop 'isa' => 'TPS::Questionnaire::Model::Question::Text';
            call 'question_text' => 'Foo?';
            call 'question_type' => 'text';
        },
        'object from just question_text',
    );

    $object = $CLASS->from_hashref({
        question_text => 'Bar?',
        question_type => 'text',
    });

    is(
        $object,
        object {
            prop 'isa' => 'TPS::Questionnaire::Model::Question::Text';
            call 'question_text' => 'Bar?';
            call 'question_type' => 'text';
        },
        'object just question_text and question_type',
    );
};

tests to_hashref => sub {
    plan(1);

    is(
        $CLASS->new(question_text => 'Foo?')->to_hashref,
        {
            question_text => 'Foo?',
            question_type => 'text',
            id => undef,
        }
    );
};

tests validate => sub {
    plan(4);

    my $q = $CLASS->new(question_text => 'Foo?');

    is(
        [$q->validate(undef)],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Answer must be text; not null";
            },
        ],
        'undef is not a valid answer',
    );

    is(
        [$q->validate([])],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Answer must be text; not an array, object, or boolean";
            },
        ],
        '[] is not a valid answer',
    );

    is(
        [$q->validate("Foo!")],
        [],
        'A non-empty string is a valid answer',
    );

    is(
        [$q->validate("")],
        [],
        'An empty string is a valid answer',
    );
};

done_testing();

1;
