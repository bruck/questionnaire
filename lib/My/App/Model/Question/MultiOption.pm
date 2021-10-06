use utf8;
package My::App::Model::Question::MultiOption;
use Moose;
use constant { true => !!1, false => !!0 };
use namespace::autoclean;

with 'My::App::Model::Question', 'My::App::Model::Question::HasOptions';

sub question_type {
    return 'multi_option';
}

__PACKAGE__->meta->make_immutable;

1;
