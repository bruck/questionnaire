#!/usr/bin/env perl
use v5.26;
use warnings;
use utf8;
package t::unit::TPS::Questionnaire::Model::ValidationError;

use Test2::V0 -target => 'TPS::Questionnaire::Model::ValidationError';
use Test2::Tools::Explain;
use Test2::Tools::Spec;

use FindBin qw($Bin $Script);
use Path::Tiny qw(path);

use TPS::Questionnaire::Model::Question::Text;

tests to_hashref => sub {
    plan(1);

    my $q = 'TPS::Questionnaire::Model::Question::Text'->new(
        question_text => 'Foo?',
    );

    is(
        $CLASS->new(
            question => $q,
            answer => 'Bar',
            error_text => 'Bar is not Foo',
        )->to_hashref,
        {
            question => {
                id => undef,
                question_type => 'text',
                question_text => 'Foo?',
            },
            answer => 'Bar',
            error_text => 'Bar is not Foo',
        },
        'Object correctly converted to hashref'
    );
};

done_testing();

1;
