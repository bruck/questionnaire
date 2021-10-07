requires 'namespace::autoclean';
requires 'Catalyst';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::View::JSON';
requires 'Config::General';
requires 'DBD::SQLite';
requires 'DBI';
requires 'DBIx::Class';
requires 'HTTP::Request::Common';
requires 'Module::Runtime';
requires 'Moose';
requires 'SQL::Translator';

on 'test' => sub {
    requires 'Path::Tiny';
    requires 'Test::Class';
    requires 'Test2::V0';
    requires 'Test2::Tools::Explain';
    requires 'Test2::Tools::Spec';
};
