package TPS::Questionnaire::Controller::API;
use Moose;
use namespace::autoclean;

use TPS::Questionnaire::Model::Questionnaire;
use TPS::Questionnaire::Model::QuestionnaireAnswer;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => 'api');


=encoding utf-8

=head1 NAME

TPS::Questionnaire::Controller::API - REST API for TPS::Questionnaire

=head1 DESCRIPTION

Handles requests for /api/*

=head1 METHODS

=head2 post_questionnaire

Handles posts to /api/questionnaire and /api/questionnaire/{id}

Without an ID, creates a new questionnaire.
With an ID, posts a response to the questionnaire.

=cut

sub post_questionnaire :Path('questionnaire') POST CaptureArgs(1) Consumes(JSON) {
    my ($self, $c, $id) = (shift, @_);

    if ($id) {
        my %posted = %{$c->request->body_data};
        $posted{questionnaire_id} = $id;
        my $qa = 'TPS::Questionnaire::Model::QuestionnaireAnswer'->from_hashref(\%posted);
        $qa->save($c->schema);
        $c->stash->{'status'} = 'ok';
        $c->stash->{'result'} = $qa->to_hashref;
        $c->forward('View::JSON');
    }
    else {
        my $q = 'TPS::Questionnaire::Model::Questionnaire'->from_hashref($c->request->body_data);
        $q->save($c->schema);
        $c->stash->{'status'} = 'ok';
        $c->stash->{'result'} = $q->to_hashref;
        $c->forward('View::JSON');
    }
}

=head2 get_questionnaire

Handles get requests to /api/questionnaire and /api/questionnaire/{id}

Lists existing questionnaires and shows existing questionnaires.

=cut

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

=head2 update_questionnaire
    Handles PUT requests to /api/questionnaire/{id}
    updates the is_published flag, to publish the questionnaire, if the questionnaire is not yet is_published
    and the submitted value of the flag is 'true'
=cut


sub update_questionnaire :Path('questionnaire') PUT CaptureArgs(1) Consumes(JSON) {
  my ($self, $c, $id) = (shift , @_);

  if ($id) {
    my %posted = %{$c->request->body_data};
    unless ($posted{'is_published'}) {
      $c->stash->{'status'} = 'error';
      $c->stash->{'error'} = 'Bad Request - Unpublishing not allowed';
      $c->response->status(400);
      return;
    }
    my $q = TPS::Questionnaire::Model::Questionnaire->from_id($c->schema, $id);
    if ($q) {
      if ($q->is_published) {
        $c->stash->{'status'} = 'error';
        $c->stash->{'error'} = 'Conflict - questionnaire already published';
        $c->response->status(409);
        return;
      }
      $q->is_published(1);
      my $result = $q->save($c->schema);
      $c->stash->{'status'} = 'ok';
      $c->stash->{'result'} = $result->to_hashref;
      $c->forward('View::JSON');
    }
    else {
        $c->stash->{'status'} = 'error';
        $c->stash->{'error'} = 'Not found';
        $c->response->status(404);
    }
  }
  else {
    $c->stash->{'status'} = 'error';
    $c->stash->{'error'} = 'Not found - No ID specified';
    $c->response->status(404);
  }

}

__PACKAGE__->meta->make_immutable;

1;
