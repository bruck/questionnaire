use strict;
use warnings;

use My::App;

my $app = My::App->apply_default_middlewares(My::App->psgi_app);
$app;

