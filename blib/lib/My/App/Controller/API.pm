package My::App::Controller::API;
use Moose;
use namespace::autoclean;

use My::App::Model::Questionnaire;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub create_questionnaire : Path('/api/questionnaire') POST Args(0) Consumes(JSON) {
    my ( $self, $c ) = ( shift, @_ );

    my $q = 'My::App::Model::Questionnaire'->from_hashref( $c->request->body_data );
    $q->save( $c->schema );
    $c->stash->{'questionnaire'} = $q->to_hashref;
    $c->forward('View::JSON');
}

sub get_questionnaire : Path('/api/questionnaire') GET CaptureArgs(1) {
    my ( $self, $c, $id ) = ( shift, @_ );

    my $q = 'My::App::Model::Questionnaire'->from_id( $c->schema, $id );

    if ( $q ) {
        $c->stash->{'questionnaire'} = $q->to_hashref;
    }
    else {
        $c->response->status( 404 );
    }

    $c->forward('View::JSON');
}

__PACKAGE__->meta->make_immutable;

1;
