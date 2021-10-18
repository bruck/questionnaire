#!/usr/bin/env perl
use v5.26;
use warnings;
use utf8;

use Test2::V0;
use Test2::Tools::Explain;

use HTTP::Request::Common;
use JSON::PP qw(decode_json encode_json);
use Path::Tiny qw(tempfile);

# The following all happens before Catalyst::Test loads the system under test.
BEGIN {
    # This causes Catalyst::Plugin::ConfigLoader to load my_app_test.conf
    # instead of my_app_local.conf.
    $ENV{TPS_QUESTIONNAIRE_CONFIG_LOCAL_SUFFIX} = 'test';

    my $database_file = tempfile();
    # MY_APP_TEST_DATABASE is used by my_app_test.conf to find the SQLite database file.
    $ENV{TPS_QUESTIONNAIRE_TEST_DATABASE} = "$database_file";

    # Turn off Catalyst debug output, please.
    $ENV{TPS_QUESTIONNAIRE_DEBUG} = 0;
}
use Catalyst::Test 'TPS::Questionnaire';

is(
    decode_json(request('/api/questionnaire')->decoded_content),
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
    decode_json(request(
        POST '/api/questionnaire',
            Content_Type => 'application/json',
            Content => encode_json({
                title => 'Sample Questionnaire',
                is_published => 1,
                questions => [ 'Foo?', 'Bar?' ],
            })
    )->code),
    200,
    'POST /api/questionnaire -> ok',
);

is(
    decode_json(request('/api/questionnaire')->decoded_content),
    {
        result => { count => 1, list => [
            { id => 1, title => 'Sample Questionnaire' },
        ] },
        status => 'ok',
    },
    'GET /api/questionnaire -> ok',
);

is(
  decode_json(request(
    POST '/api/questionnaire',
      Content_Type => 'application/json',
      Content => encode_json({
          title => 'Sample Unpublished Questionnaire',
          is_published => 0,
          questions => [ 'Foo?', 'Bar?' ],
     })
 )->code),
  200,
  'POST unpublised questionnaire -> ok'
);

is(
    decode_json(request('/api/questionnaire/2')->decoded_content),
    {
        result => { is_published => 'false' },
        status => 'ok',
    },
    'GET /api/questionnaire/2 - unpublished questionnaire -> ok',
);

is(
    decode_json(request(
        PUT '/api/questionnaire/1',
            Content_Type => 'application/json',
            Content => encode_json({
                title => 'Sample Questionnaire',
                is_published => 0,
                questions => [ 'Foo?', 'Bar?' ],
            })
    )->code),
    400,
    'PUT /api/questionnaire/1 - can\'t unpublish a published questionnaire -> ok',
);

is(
    decode_json(request(
        PUT '/api/questionnaire/1',
            Content_Type => 'application/json',
            Content => encode_json({
                title => 'Sample Questionnaire',
                is_published => 1,
                questions => [ 'Foo?', 'Bar?' ],
            })
    )->code),
    409,
    'PUT /api/questionnaire/1 -  questionnaire is already published-> ok',
);

is(
    decode_json(request(
        PUT '/api/questionnaire/2',
            Content_Type => 'application/json',
            Content => encode_json({
                title => 'Sample Questionnaire',
                is_published => 1,
                questions => [ 'Foo?', 'Bar?' ],
            })
    )->code),
    200,
    'PUT /api/questionnaire/2 -  publish this questionnaire-> ok',
);

is(
    decode_json(request('/api/questionnaire/2')->decoded_content),
    {
        result => { is_published => 'true' },
        status => 'ok',
    },
    'GET /api/questionnaire/2 -  questionnaire has been published -> ok',
);


done_testing();
