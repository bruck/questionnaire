use v5.26;
use utf8;
package TPS::Questionnaire::Model::Questionnaire;

use Moose;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

use Carp qw(carp croak);
use Module::Runtime qw(use_module is_module_name);

has id => (
    is => 'rw',
    isa => 'Int',
    clearer => 'clear_id',
    predicate => 'has_id',
);

has title => (
    is => 'rw',
    isa => 'Str',
    required => true,
);

has is_published => (
    is => 'rw',
    isa => 'Bool',
    default => sub { return false; },
);

has questions => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { return []; },
    traits => [ 'Array' ],
    handles => {
        add_question => 'push',
    },
);


# Returns the question model module given the question type.
# Defaults to 'text' question type.
sub _question_module {
    my ($question_type) = @_;
    $question_type //= 'text';

    my $class = 'TPS::Questionnaire::Model::Question::'
        . join("", map { ucfirst } (split /_|\s+/, lc $question_type));

    croak "Cannot construct a valid module name for question type '$question_type'"
        unless is_module_name($class);

    return use_module($class);
}


sub from_hashref {
    my ($class, $data) = (shift, @_);

    my $self = $class->new(
        title => $data->{'title'},
        is_published => $data->{'is_published'},
    );

    for my $q_data (@{$data->{'questions'} // []}) {
        if (!ref $q_data) {
            $q_data = { question_text => $q_data };
        }
        my $q_class = _question_module($q_data->{'question_type'});
        $self->add_question($q_class->from_hashref($q_data));
    }

    return $self;
}

sub to_hashref {
    my ($self) = (shift);

    my $h = {
        title => $self->title,
        is_published => $self->is_published ? \1 : \0,
        questions => [ map $_->to_hashref, @{$self->questions} ],
    };

    return $h;
}

sub from_id {
    my ($class, $schema, $id) = (shift, @_);

    my $rs = $schema
        ->resultset('Questionnaire')
        ->search({ questionnaire_id => $id });
    my $result = $rs->next
        or return;

    return $class->from_db_object($schema, $result);
}

sub from_db_object {
    my ($class, $schema, $result) = (shift, @_);

    my $self = $class->new(
        id => $result->questionnaire_id,
        title => $result->title,
        is_published => $result->is_published,
    );

    my $rs = $result->questionnaire_question->search(
        undef,
        { order_by => 'rank', prefetch => 'question' },
    );

    while (my $qq = $rs->next) {
        my $q = $qq->question;
        my $q_class = _question_module($q->question_type);
        $self->add_question($q_class->from_db_object($schema, $q));
    }

    return $self;
}

sub save {
    my ($self, $schema) = (shift, @_);

    # Even though this object has 'rw' attributes, questionnaires are
    # conceptually write-once.
    if ($self->has_id) {
        carp 'Save questionnaire which already exists';
        return $self->id;
    }

    my $result = $schema
        ->resultset('Questionnaire')
        ->create({
        title => $self->title,
        is_published => $self->is_published,
    });

    $self->id($result->questionnaire_id);

    my $rank = 0;
    for my $q (@{$self->questions}) {
        $q->_save($self, ++$rank, @_);
    }

    return $self->id;
}

sub summary_list {
    my ($class, $schema, $id) = (shift, @_);
    my @return;

    my $rs = $schema
        ->resultset('Questionnaire')
        ->search({ is_published => true });
    while (my $q = $rs->next) {
        push @return, {
            id => $q->questionnaire_id,
            title => $q->title,
        };
    }

    \@return;
}

__PACKAGE__->meta->make_immutable;

1;
