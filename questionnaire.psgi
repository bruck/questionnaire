use strict;
use warnings;

use TPS::Questionnaire;

my $app = TPS::Questionnaire->apply_default_middlewares(TPS::Questionnaire->psgi_app);
$app;

