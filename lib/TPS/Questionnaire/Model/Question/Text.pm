use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question::Text;
use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

=head1 NAME

TPS::Questionnaire::Model::Question::Text - represents a text-input question

=head1 DESCRIPTION

This class represents a question which accepts free text input.

It consumes the L<TPS::Questionnaire::Model::Question> role.

=cut

with 'TPS::Questionnaire::Model::Question';

=head1 METHODS

=head2 question_type

Returns the string "text".

=cut

sub question_type {
    return 'text';
}

=head1 AUTHOR

Toby Inkster, tinkster@theperlshop.net

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
