package TPS::Questionnaire::Controller::Root;
use Moose;
use Pod::Simple::HTML;
use Path::Tiny 'path';
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

TPS::Questionnaire::Controller::Root - Root Controller for TPS::Questionnaire

=head1 DESCRIPTION

Handles requests for "/" and 404 errors.

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    my $docs = path(__FILE__)->parent->child('API.pm');
    my $p = 'Pod::Simple::HTML'->new;
    $p->output_string(\my $html);
    $p->parse_file("$docs");
    $c->response->body($html);
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ($self, $c) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end :ActionClass('RenderView') {}

=head1 AUTHOR

Toby Inkster, tinkster@theperlshop.net

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;