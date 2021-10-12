use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question::MultiOption;

use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

=head1 NAME

TPS::Questionnaire::Model::Question::MultiOption - represents a multiple choice question where you can select zero or more options

=head1 DESCRIPTION

This class represents a question which allows a multiple choices of option.

It consumes the L<TPS::Questionnaire::Model::Question> and
L<TPS::Questionnaire::Model::Question::HasOptions> roles.

=cut

with 'TPS::Questionnaire::Model::Question', 'TPS::Questionnaire::Model::Question::HasOptions';

=head1 METHODS

=head2 question_type

Returns the string "multi_option".

=cut

sub question_type {
    return 'multi_option';
}

=head2 validate($answer)

Checks that the answer is an arrayref of valid options.

Returns a list of errors.

=cut

sub validate {
    my ($self, $answer) = (shift, @_);
    my @errors;

    if ('ARRAY' eq ref($answer)//'') {
        my $i = 0;
        for my $selected (@$answer) {
            ++$i;
            if (defined $selected) {
                if (ref $selected) {
                    push @errors, $self->_error($answer, "Answer $i must be one of the given options; not an array, object, or boolean");
                }
                else {
                    if ($selected =~ /\A[0-9]+\z/) {
                        my $found;
                        for my $option (@{$self->options}) {
                            if ($selected == $option->id) {
                                ++$found;
                                last;
                            }
                        }
                        push @errors, $self->_error($answer, "Answer $i must be one of the given options; not custom text")
                            if !$found;
                    }
                    else {
                        push @errors, $self->_error($answer, "Answer $i must be numeric");
                    }
                }
            }
            else {
                push @errors, $self->_error($answer, "Answer $i must be one of the given options; not null");
            }
        }
    }
    else {
        push @errors, $self->_error($answer, "Must be an array of answers");
    }

    return @errors;
}


__PACKAGE__->meta->make_immutable;

1;
