#!/usr/bin/env perl

use lib '.';
use inc::Module::Install 1.02;
use Module::Install::Catalyst;

name 'TPS-Questionnaire';
all_from 'lib/TPS/Questionnaire.pm';

requires 'Catalyst::Runtime' => '5.90128';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General';
requires 'Catalyst::View::JSON';
requires 'DBD::SQLite';
requires 'DBI';
requires 'DBIx::Class';
requires 'HTTP::Request::Common';
requires 'Module::Runtime';
requires 'SQL::Translator';

test_requires 'Path::Tiny';
test_requires 'Test::Class';
test_requires 'Test2::V0';
test_requires 'Test2::Tools::Explain';
test_requires 'Test2::Tools::Spec';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
