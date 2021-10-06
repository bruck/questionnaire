use utf8;
package My::App::Model::Question;
use Moose::Role;
use constant { true => !!1, false => !!0 };
use namespace::autoclean;

requires qw( question_type );

has 'id' => (
    is          => 'rw',
    isa         => 'Int',
    clearer     => 'clear_id',
    predicate   => 'has_id',
);

has 'question_text' => (
    is          => 'rw',
    isa         => 'Str',
    required    => true,
);

sub from_hashref {
    my ( $class, $data ) = ( shift, @_ );

    my $self = $class->new(
        question_text => $data->{'question_text'},
    );

    return $self;
}

sub to_hashref {
    my ( $self ) = ( shift );

    my $h = {
        id            => $self->id,
        question_text => $self->question_text,
    };

    return $h;
}

sub from_db_object {
    my ( $class, $schema, $result ) = ( shift, @_ );

    my $self = $class->new(
        id            => $result->question_id,
        question_text => $result->question_text,
    );

    return $self;
}

1;
