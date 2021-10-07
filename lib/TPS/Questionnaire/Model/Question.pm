use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question;

use Moose::Role;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

=encoding utf-8

=head1 NAME

TPS::Questionnaire::Model::Question - represents a question

=head1 DESCRIPTION

This role represents a question which may belong to a questionnaire.

It is consumed by question type classes.

=head1 REQUIRED METHODS

These methods are not provided by the role, but must be provided by classes
that consume it.

=head2 question_type

The question type code for storing the question in the database.

=cut

requires qw(question_type);

=head1 ATTRIBUTES

=head2 id

Integer ID for the question. Will not be defined if the question is
not yet stored in the database.

C<clear_id> may be used to clear an existing ID, allowing it to be re-stored
in the database with a different ID. C<has_id> indicates if this question
has an ID.

=cut

has id => (
    is => 'rw',
    isa => 'Int',
    clearer => 'clear_id',
    predicate => 'has_id',
);

=head2 question_text

Required string; the text of the question.

=cut

has question_text => (
    is => 'rw',
    isa => 'Str',
    required => true,
);

=head1 METHODS

=head2 from_hashref(\%data)

An alternative constructor which creates a question object from a
hashref of data, formatted in the same manner the API accepts.
This is a good target for modifying in consuming classes if the question type
needs to read additional data, such as using a Moose C<around> modifier.

=cut

sub from_hashref {
    my ($class, $data) = (shift, @_);

    my $self = $class->new(
        question_text => $data->{'question_text'},
    );

    return $self;
}

=head2 to_hashref

Creates a hashref of data for this question, suitable for JSON serialization.
This is a good target for modifying in consuming classes if the question type
needs to store additional data, such as using a Moose C<around> modifier.

=cut

sub to_hashref {
    my ($self) = (shift);

    my $h = {
        id => $self->id,
        question_text => $self->question_text,
    };

    return $h;
}

=head2 from_db_object($schema, $result)

Alternative constructor which creates a question object from a
L<TPS::Questionnaire::Schema> object and the question's
L<TPS::Questionnaire::Schema::Result::Question> object.
This is a good target for modifying in consuming classes if the question type
needs to read additional data, such as using a Moose C<around> modifier.

=cut

sub from_db_object {
    my ($class, $schema, $result) = (shift, @_);

    my $self = $class->new(
        id => $result->question_id,
        question_text => $result->question_text,
    );

    return $self;
}

=head2 _save($questionnaire, $rank, $schema)

Used by L<TPS::Questionnaire::Model::Questionnaire>.

=cut

sub _save {
    my ($self, $questionnaire, $rank, $schema) = (shift, @_);

    my $result_q = $schema
        ->resultset('Question')
        ->create({
        'question_type' => $self->question_type,
        'question_text' => $self->question_text,
    });

    $self->id($result_q->question_id);

    my $result_qq = $schema
        ->resultset('QuestionnaireQuestion')
        ->create({
        questionnaire_id => $questionnaire->id,
        'question_id' => $self->id,
        'rank' => $rank,
    });

    return $self->id;
}

=head1 AUTHOR

Toby Inkster, tinkster@theperlshop.net

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
