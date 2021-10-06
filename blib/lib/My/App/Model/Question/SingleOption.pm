use utf8;
package My::App::Model::Question::SingleOption;
use Moose;
use constant { true => !!1, false => !!0 };
use namespace::autoclean;

with 'My::App::Model::Question', 'My::App::Model::Question::HasOptions';

sub question_type {
    return 'single_option';
}

__PACKAGE__->meta->make_immutable;

1;
