use utf8;
package My::App::Model::Question::Text;
use Moose;
use constant { true => !!1, false => !!0 };
use namespace::autoclean;

with 'My::App::Model::Question';

sub question_type {
    return 'text';
}

__PACKAGE__->meta->make_immutable;

1;
