use v5.26;
use utf8;
package TPS::Questionnaire::Model::Question::HasOptions;

use Moose::Role;
use namespace::autoclean;

use constant { true => !!1, false => !!0 };

use Module::Runtime 'use_module';
use TPS::Questionnaire::Model::Option;

=head1 NAME

TPS::Questionnaire::Model::Question::HasOptions - code shared between question types that have options

=head1 DESCRIPTION

A Moose role for code shared between question types that have options.

=head1 ATTRIBUTES

=head2 options

An array of L<TPS::Questionnaire::Model::Option> objects.
Defaults to the empty array.
Also provides a C<add_option> method to add an option to the end of the array.

=cut

has options => (
    is => 'rw',
    isa => 'ArrayRef[TPS::Questionnaire::Model::Option]',
    default => sub { return []; },
    traits => [ 'Array' ],
    handles => {
        add_option => 'push',
    },
);

=head1 METHOD MODIFIERS

This role modifies the C<from_hashref>, C<to_hashref>, C<from_db_object>, and
C<_save> methods to load and save options.

=cut

around from_hashref => sub {
    my ($next, $class, $data) = (shift, shift, @_);

    my $self = $class->$next(@_);

    for my $opt_data (@{$data->{'options'} // []}) {
        if (!ref $opt_data) {
            $opt_data = { option_text => $opt_data };
        }
        my $opt_class = 'TPS::Questionnaire::Model::Option';
        $self->add_option($opt_class->from_hashref($opt_data));
    }

    return $self;
};

around to_hashref => sub {
    my ($next, $self) = (shift, shift);
    my $h = $self->$next(@_);
    $h->{'options'} = [ map $_->to_hashref, @{$self->options} ];
    return $h;
};

around from_db_object => sub {
    my ($next, $class, $schema, $result) = (shift, shift, @_);

    my $self = $class->$next(@_);

    my $rs = $result->options->search(
        { question_id => $result->question_id },
        { order_by => 'option_rank' },
    );

    while (my $opt = $rs->next) {
        my $opt_class = 'TPS::Questionnaire::Model::Option';
        $self->add_option(use_module($opt_class)->from_db_object($schema, $opt));
    }

    return $self;
};

around _save => sub {
    my ($next, $self, $questionnaire, $rank, $schema) = (shift, shift, @_);

    my $return = $self->$next(@_);

    my $option_rank = 0;
    for my $option (@{$self->options}) {
        $option->_save($self, ++$option_rank, $schema);
    }

    return $return;
};


1;
