package TPS::Questionnaire::Controller::API;
use Moose;
use namespace::autoclean;

use TPS::Questionnaire::Model::Questionnaire;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => 'api');

sub create_questionnaire :Path('questionnaire') POST Args(0) Consumes(JSON) {
    my ($self, $c) = (shift, @_);

    my $q = TPS::Questionnaire::Model::Questionnaire->from_hashref($c->request->body_data);
    $q->save($c->schema);
    $c->stash->{'status'} = 'ok';
    $c->stash->{'result'} = $q->to_hashref;
    $c->forward('View::JSON');
}

sub get_questionnaire :Path('questionnaire') GET CaptureArgs(1) {
    my ($self, $c, $id) = (shift, @_);

    if ($id) {
        my $q = TPS::Questionnaire::Model::Questionnaire->from_id($c->schema, $id);
        if ($q) {
            $c->stash->{'status'} = 'ok';
            $c->stash->{'result'} = $q->to_hashref;
        }
        else {
            $c->stash->{'status'} = 'error';
            $c->stash->{'error'} = 'Not found';
            $c->response->status(404);
        }
    }
    else {
        my $q = TPS::Questionnaire::Model::Questionnaire->summary_list($c->schema);
        $c->stash->{'status'} = 'ok';
        $c->stash->{'result'} = { list => $q, count => scalar(@$q) };
    }

    $c->forward('View::JSON');
}

__PACKAGE__->meta->make_immutable;

1;
