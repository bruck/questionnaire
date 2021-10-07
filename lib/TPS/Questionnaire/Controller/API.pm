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

POST format to create a new questionnaire:

    {
        "title": "Questionnaire Title",
        "is_published": true,
        "questions": [
            {
                "question_text": "What is your name?"
                "question_type": "text"
            },
            {
                "question_text": "What is your favourite colour?",
                "question_type": "single_option",
                "options": [
                    { "option_text": "Red" },
                    { "option_text": "Blue" },
                    { "option_text": "Yellow" },
                    { "option_text": "Green" }
                ]
            },
            {
                "question_text": "Do you have a pet?"
                "question_type": "multi_option",
                "options": [
                    { "option_text": "Dog" },
                    { "option_text": "Cat" },
                    { "option_text": "Rabbit" },
                    { "option_text": "Other" }
                ]
            }
        ]
    }

Questions default to being "text" questions. Objects which only have
question_text or option_text can be collapsed to a string. So the above
can be written as:

    {
        "title": "Questionnaire Title",
        "is_published": true,
        "questions": [
            "What is your name?",
            {
                "question_text": "What is your favourite colour?",
                "question_type": "single_option",
                "options": [ "Red", "Blue", "Yellow", "Green" ]
            },
            {
                "question_text": "Do you have a pet?"
                "question_type": "multi_option",
                "options": [ "Dog", "Cat", "Rabbit", "Other" ]
            }
        ]
    }

Response format:

    {
        "status": "ok",
        "result": { ... questionnaire object ... }
    }

Request format for posting a response:

    {
        "user_id": 123,
        "answers": {
            "1": "Toby Inkster",
            "2": 4,
            "3": [5, 6]
        }
    }

The keys to the answers object are question ID numbers.
The values are option IDs, arrays of option IDs, or text answers.

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

TODO: handle pagination

Response format for list (i.e. no ID):

    {
        "status": "ok",
        "result": {
            "count": 1,
            "list": [ ... ]
        }
    }

Response format for questionnaire (i.e. numeric ID):

    {
        "status": "ok",
        "result": { ... questionnaire object ... }
    }

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

=head1 AUTHOR

Toby Inkster, tinkster@theperlshop.net

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
