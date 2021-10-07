use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question::Text;
use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

with 'TPS::Questionnaire::Model::Question';

sub question_type {
    return 'text';
}

__PACKAGE__->meta->make_immutable;

1;
