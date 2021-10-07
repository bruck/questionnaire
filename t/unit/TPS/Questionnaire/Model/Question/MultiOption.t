#!/usr/bin/env perl
use v5.26;
use warnings;
use utf8;
package t::unit::TPS::Questionnaire::Model::Question::MultiOption;

use Test2::V0 -target => 'TPS::Questionnaire::Model::Question::MultiOption';
use Test2::Tools::Explain;
use Test2::Tools::Spec;

use FindBin qw($Bin $Script);
use Path::Tiny qw(path);

tests from_hashref => sub {
    plan(1);

    my $object = $CLASS->from_hashref({
        question_text => 'Foo?',
        options       => [ 'Yes', 'No', { option_text => 'Maybe' } ]
    });

    is(
        $object,
        object {
            prop 'isa' => 'TPS::Questionnaire::Model::Question::MultiOption';
            call 'question_text' => 'Foo?';
            call 'question_type' => 'multi_option';
            call 'options' => array {
                item object {
                    prop 'isa' => 'TPS::Questionnaire::Model::Option';
                    call 'option_text' => 'Yes';
                };
                item object {
                    prop 'isa' => 'TPS::Questionnaire::Model::Option';
                    call 'option_text' => 'No';
                };
                item object {
                    prop 'isa' => 'TPS::Questionnaire::Model::Option';
                    call 'option_text' => 'Maybe';
                };
                end();
            };
        },
        'object from question_text and options',
    );
};

tests to_hashref => sub {
    plan(1);

    is(
        $CLASS->new(
            question_text => 'Foo?',
            options => [
                'TPS::Questionnaire::Model::Option'->new(option_text => 'Yes', id => 666),
                'TPS::Questionnaire::Model::Option'->new(option_text => 'No', id => 777),
            ],
        )->to_hashref,
        {
            question_text => 'Foo?',
            question_type => 'multi_option',
            id => undef,
            options => [
                {option_text => 'Yes', id => 666},
                {option_text => 'No', id => 777},
            ],
        }
    );
};

tests validate => sub {
    plan(6);

    my $q = $CLASS->new(
        question_text => 'Foo?',
        options => [
            'TPS::Questionnaire::Model::Option'->new(option_text => 'Yes', id => 666),
            'TPS::Questionnaire::Model::Option'->new(option_text => 'No', id => 777),
        ],
    );

    is(
        [$q->validate(undef)],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Must be an array of answers";
            },
        ],
        'undef is not a valid answer',
    );

    is(
        [$q->validate(777)],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Must be an array of answers";
            },
        ],
        '777 is not a valid answer as it\'s not an array',
    );

    is(
        [$q->validate([])],
        [],
        '[] is a valid answer',
    );

    is(
        [$q->validate([888])],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Answer 1 must be one of the given options; not custom text";
            },
        ],
        '[888] is not a valid answer',
    );

    is(
        [$q->validate([666,888])],
        [
            object {
                prop 'isa' => 'TPS::Questionnaire::Model::ValidationError';
                call 'error_text' => "Answer 2 must be one of the given options; not custom text";
            },
        ],
        '[666,888] is not a valid answer',
    );

    is(
        [$q->validate([666,777])],
        [],
        '[666,777] is a valid answer',
    );
};

done_testing();

1;
