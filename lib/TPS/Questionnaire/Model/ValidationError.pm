use v5.26;
use utf8;
package TPS::Questionnaire::Model::ValidationError;

use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

=encoding utf-8

=head1 NAME

TPS::Questionnaire::Model::ValidationError - a validation error

=head1 DESCRIPTION

This class represents an issue with a questionnaire response.

=head1 ATTRIBUTES

=head2 question

Required object; the question object.

=cut

has question => (
    is => 'rw',
    isa => 'Object',
    required => true,
);

=head2 answer

The answer.

=cut

has answer => (
    is => 'rw',
    isa => 'Any',
);

=head2 error_text

Required string; an explanation of the error.

=cut

has error_text => (
    is => 'rw',
    isa => 'Str',
    required => true,
);

=head1 METHODS

=head2 to_hashref

Creates a hashref of data for this option, suitable for JSON serialization.

=cut

sub to_hashref {
    my ($self) = (shift);

    my $h = {
        question => $self->question->to_hashref,
        answer => $self->answer,
        error_text => $self->error_text,
    };

    return $h;
}


__PACKAGE__->meta->make_immutable;

1;
