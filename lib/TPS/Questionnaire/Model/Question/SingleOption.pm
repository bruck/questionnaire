use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question::SingleOption;

use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

with 'TPS::Questionnaire::Model::Question', 'TPS::Questionnaire::Model::Question::HasOptions';

sub question_type {
    return 'single_option';
}

__PACKAGE__->meta->make_immutable;

1;
