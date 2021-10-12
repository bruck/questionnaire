use v5.26;
use utf8;
package TPS::Questionnaire::Model::QuestionnaireAnswer;

use Moose;
use namespace::autoclean;

use Carp 'croak';
use constant { true => !!1, false => !!0 };

=encoding utf-8

=head1 NAME

TPS::Questionnaire::Model::QuestionnaireAnswer - represents a response to a questionnaire

=head1 DESCRIPTION

This role represents a response to a questionnaire, encompassing answers to
zero or more of its questions.

=head1 ATTRIBUTES

=head2 id

Integer ID for the response. Will not be defined if the response is
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

=head2 user_id

Required integer; the user ID of the respondent.

=cut

has user_id => (
    is => 'rw',
    isa => 'Int',
    required => true,
);

=head2 answered_at

Integer; the UTC timestamp the response was submitted.

=cut

has answered_at => (
    is => 'rw',
    isa => 'Int',
    default => sub { return time(); },
);

=head2 questionnaire_id

Required integer; the ID of the questionnaire.

=cut

has questionnaire_id => (
    is => 'rw',
    isa => 'Int',
    required => true,
);

=head2 _raw_answers

Required hashref; an { ID => answer } hashref.

The constructor argument is C<answers>.

=cut

has _raw_answers => (
    is => 'rw',
    isa => 'HashRef',
    required => true,
    init_arg => 'answers',
);

=head1 METHODS

=head2 from_hashref(\%data)

An alternative constructor which creates a response object from a
hashref of data, formatted in the same manner the API accepts.

=cut

sub from_hashref {
    my ($class, $data) = (shift, @_);

    my $self = $class->new(
        user_id => $data->{'user_id'},
        answered_at => $data->{'answered_at'} // time(),
        questionnaire_id => $data->{'questionnaire_id'},
        answers => $data->{'answers'} // {},
    );

    return $self;
}

=head2 to_hashref

Creates a hashref of data for this response, suitable for JSON serialization.

=cut

sub to_hashref {
    my ($self) = (shift);

    my $h = {
        id => $self->id,
        user_id => $self->user_id,
        answered_at => $self->answered_at,
        questionnaire_id => $self->questionnaire_id,
        answers => $self->_raw_answers,
    };

    return $h;
}

=head2 from_db_object($schema, $result)

Alternative constructor which creates a response object from a
L<TPS::Questionnaire::Schema> object and the question's
L<TPS::Questionnaire::Schema::Result::QuestionnaireAnswer> object.

=cut

sub from_db_object {
    my ($class, $schema, $result) = (shift, @_);
    ...;
}

=head2 validate_answers($schema)

Check that the answers are valid answers for the questionnaire. Requires
a L<TPS::Questionnaire::Schema> object in order to look up the questionnaire's
questions.

Returns a list of validation errors, or the empty list if all answers are
valid. Each validation error is a L<TPS::Questionnaire::Model::ValidationError>.

=cut

sub validate_answers {
    my ($self, $schema) = (shift, @_);
    my $answers = $self->_raw_answers;
    my $questionnaire = 'TPS::Questionnaire::Model::Questionnaire'->from_id(
        $schema,
        $self->questionnaire_id,
    );
    my @errors;

    for my $question (@{$questionnaire->questions}) {
        exists $answers->{$question->id} or next;
        my $answer = $answers->{$question->id};

        push @errors, $question->validate($answer);
    }

    return @errors;
}

=head2 save($schema)

Save the response including all its answers to the database.

=cut

sub save {
    my ($self, $schema) = (shift, @_);

    croak "Cannot save answer with validation errors"
        if $self->validate_answers($schema);

    ...;

    return $self->id;
}

1;
