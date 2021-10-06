use utf8;
package My::App::Model::Questionnaire;
use Moose;
use constant { true => !!1, false => !!0 };
use namespace::autoclean;

use Module::Runtime 'use_module';
use My::App::Util 'mk_module_name';

has 'id' => (
    is          => 'rw',
    isa         => 'Int',
    clearer     => 'clear_id',
    predicate   => 'has_id',
);

has 'title' => (
    is          => 'rw',
    isa         => 'Str',
    required    => true,
);

has 'is_published' => (
    is          => 'rw',
    isa         => 'Bool',
    default     => sub { return false; },
);

has 'questions' => (
    is          => 'rw',
    isa         => 'ArrayRef',
    default     => sub { return []; },
    traits      => [ 'Array' ],
    handles     => {
        'add_question' => 'push',
    },
);

sub from_hashref {
    my ( $class, $data ) = ( shift, @_ );

    my $self = $class->new(
        title        => $data->{'title'},
        is_published => $data->{'is_published'},
    );

    for my $q_data ( @{ $data->{'questions'} // [] } ) {
        if ( ! ref $q_data ) {
            $q_data = { 'question_text' => $q_data };
        }
        my $q_class = mk_module_name(
            $q_data->{'question_type'} // 'text',
            'My::App::Model::Question',
        );
        $self->add_question( use_module($q_class)->from_hashref( $q_data ) );
    }

    return $self;
}

sub to_hashref {
    my ( $self ) = ( shift );

    my $h = {
        title        => $self->title,
        is_published => $self->is_published ? \1 : \0,
        questions    => [ map $_->to_hashref, @{ $self->questions } ],
    };

    return $h;
}

sub from_id {
    my ( $class, $schema, $id ) = ( shift, @_ );

    my $rs = $schema
        ->resultset( 'Questionnaire' )
        ->search( { questionnaire_id => $id } );
    my $result = $rs->next
        or return;

    return $class->from_db_object( $schema, $result );
}

sub from_db_object {
    my ( $class, $schema, $result ) = ( shift, @_ );

    my $self = $class->new(
        id           => $result->questionnaire_id,
        title        => $result->title,
        is_published => $result->is_published,
    );

    my $rs = $result->questionnaire_questions->search(
        undef,
        { order_by => 'rank', prefetch => 'question' },
    );

    while ( my $qq = $rs->next ) {
        my $q = $qq->question;
        my $q_class = mk_module_name(
            $q->question_type // 'text',
            'My::App::Model::Question',
        );
        $self->add_question( $q_class->from_db_object( $schema, $q ) );
    }

    return $self;
}

__PACKAGE__->meta->make_immutable;

1;
