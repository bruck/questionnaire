use v5.26;
use utf8;
package TPS::Questionnaire::Model::Option;

use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

=encoding utf-8

=head1 NAME

TPS::Questionnaire::Model::Question - represents a question

=head1 DESCRIPTION

This role represents a question which may belong to a questionnaire.

It is consumed by question type classes.

=head1 ATTRIBUTES

=head2 id

Integer ID for the option. Will not be defined if the option is
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

=head2 option_text

Required string; the text of the option.

=cut

has option_text => (
    is => 'rw',
    isa => 'Str',
    required => true,
);

=head1 METHODS

=head2 from_hashref(\%data)

An alternative constructor which creates an option object from a
hashref of data, formatted in the same manner the API accepts.

=cut

sub from_hashref {
    my ($class, $data) = (shift, @_);

    my $self = $class->new(
        option_text => $data->{'option_text'},
    );

    return $self;
}

=head2 to_hashref

Creates a hashref of data for this option, suitable for JSON serialization.

=cut

sub to_hashref {
    my ($self) = (shift);

    my $h = {
        id => $self->id,
        option_text => $self->option_text,
    };

    return $h;
}

=head2 from_db_object($schema, $result)

Alternative constructor which creates an option object from a
L<TPS::Questionnaire::Schema> object and the options's
L<TPS::Questionnaire::Schema::Result::Option> object.

=cut

sub from_db_object {
    my ($class, $schema, $result) = (shift, @_);

    my $self = $class->new(
        id => $result->option_id,
        option_text => $result->option_text,
    );

    return $self;
}

=head2 _save($question, $rank, $schema)

Used by L<TPS::Questionnaire::Model::Question>.

=cut

sub _save {
    my ($self, $question, $rank, $schema) = (shift, @_);

    my $result = $schema
        ->resultset('Option')
        ->create({
        'option_text' => $self->option_text,
        'option_rank' => $rank,
        'question_id' => $question->id,
    });

    $self->id($result->option_id);

    return $self->id;
}

=head1 AUTHOR

Toby Inkster, tinkster@theperlshop.net

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
