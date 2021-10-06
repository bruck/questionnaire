#!/usr/bin/env perl
use strict;
use warnings;
use Test2::V0;
use Test2::Tools::Explain;
use JSON::PP qw( decode_json encode_json );

use HTTP::Request::Common;

BEGIN {
    $ENV{'MY_APP_CONFIG_LOCAL_SUFFIX'} = 'test';
};

use Catalyst::Test 'My::App';

is(
    decode_json( request('/api/questionnaire')->decoded_content ),
    {
        result => { count => 0, list => [] },
        status => 'ok',
    },
    'GET /api/questionnaire -> ok',
);

is(
    request('/api/questionnaire/1')->code,
    404,
    'GET /api/questionnaire/1 -> 404',
);

is(
    decode_json( request(
        POST '/api/questionnaire',
            Content_Type => 'application/json',
            Content => encode_json( {
                title => 'Sample Questionnaire',
                is_published => \1,
                questions => [ 'Foo?', 'Bar?' ],
            } )
    )->code ),
    200,
    'GET /api/questionnaire -> ok',
);

is(
    decode_json( request('/api/questionnaire')->decoded_content ),
    {
        result => { count => 1, list => [
            { id => 1, title => 'Sample Questionnaire' },
        ] },
        status => 'ok',
    },
    'GET /api/questionnaire -> ok',
);

done_testing();
