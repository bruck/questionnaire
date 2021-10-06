use utf8;
package My::App::Model::Option;
use Moose;
use constant { true => !!1, false => !!0 };
use namespace::autoclean;

has 'id' => (
    is          => 'rw',
    isa         => 'Int',
    clearer     => 'clear_id',
    predicate   => 'has_id',
);

has 'option_text' => (
    is          => 'rw',
    isa         => 'Str',
    required    => true,
);

sub from_hashref {
    my ( $class, $data ) = ( shift, @_ );

    my $self = $class->new(
        option_text  => $data->{'option_text'},
    );

    return $self;
}

sub to_hashref {
    my ( $self ) = ( shift );

    my $h = {
        id          => $self->id,
        option_text => $self->option_text,
    };

    return $h;
}

sub from_db_object {
    my ( $class, $schema, $result ) = ( shift, @_ );

    my $self = $class->new(
        id          => $result->option_id,
        option_text => $result->option_text,
    );

    return $self;
}

sub _save {
    my ( $self, $question, $rank, $schema ) = ( shift, @_ );

    my $result = $schema
        ->resultset( 'Option' )
        ->create( {
            'option_text'  => $self->option_text,
            'option_rank'  => $rank,
            'question_id'  => $question->id,
        } );

    $self->id( $result->option_id );

    return $self->id;
}

__PACKAGE__->meta->make_immutable;

1;
