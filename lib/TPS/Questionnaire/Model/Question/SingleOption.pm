use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question::SingleOption;

use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

=head1 NAME

TPS::Questionnaire::Model::Question::SingleOption - represents a multiple choice question where you can select a single option

=head1 DESCRIPTION

This class represents a question which allows a single choice of option.

It consumes the L<TPS::Questionnaire::Model::Question> and
L<TPS::Questionnaire::Model::Question::HasOptions> roles.

=cut

with 'TPS::Questionnaire::Model::Question', 'TPS::Questionnaire::Model::Question::HasOptions';

=head1 METHODS

=head2 question_type

Returns the string "single_option".

=cut

sub question_type {
    return 'single_option';
}

=head2 validate($answer)

Checks that the answer is the ID of a valid option.

Returns a list of errors.

=cut

sub validate {
    my ($self, $answer) = (shift, @_);
    my @errors;

    if (defined $answer) {
        if (ref $answer) {
            push @errors, $self->_error($answer, "Answer must be one of the given options; not an array, object, or boolean");
        }
        else {
            if ($answer =~ /\A[0-9]+\z/) {
                my $found;
                for my $option (@{$self->options}) {
                    if ($answer == $option->id) {
                        ++$found;
                        last;
                    }
                }
                push @errors, $self->_error($answer, "Answer must be one of the given options; not custom text")
                    if !$found;
            }
            else {
                push @errors, $self->_error($answer, "Answer must be numeric");
            }
        }
    }
    else {
        push @errors, $self->_error($answer, "Answer must be one of the given options; not null");
    }

    return @errors;
}

=head1 AUTHOR

Toby Inkster, tinkster@theperlshop.net

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
