use utf8;
package My::App::Schema::Result::QuestionnaireQuestion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

My::App::Schema::Result::QuestionnaireQuestion

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<questionnaire_question>

=cut

__PACKAGE__->table("questionnaire_question");

=head1 ACCESSORS

=head2 questionnaire_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 question_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "questionnaire_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "question_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</questionnaire_id>

=item * L</question_id>

=back

=cut

__PACKAGE__->set_primary_key("questionnaire_id", "question_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<questionnaire_id_rank_unique>

=over 4

=item * L</questionnaire_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint("questionnaire_id_rank_unique", ["questionnaire_id", "rank"]);

=head1 RELATIONS

=head2 question

Type: belongs_to

Related object: L<My::App::Schema::Result::Question>

=cut

__PACKAGE__->belongs_to(
  "question",
  "My::App::Schema::Result::Question",
  { question_id => "question_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 questionnaire

Type: belongs_to

Related object: L<My::App::Schema::Result::Questionnaire>

=cut

__PACKAGE__->belongs_to(
  "questionnaire",
  "My::App::Schema::Result::Questionnaire",
  { questionnaire_id => "questionnaire_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yAHqKopE18KSGvQytyZYwg
# These lines were loaded from '/home/tai/perl5/perlbrew/perls/perl-5.34.0/lib/site_perl/5.34.0/My/App/Schema/Result/QuestionnaireQuestion.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package My::App::Schema::Result::QuestionnaireQuestion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

My::App::Schema::Result::QuestionnaireQuestion

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<questionnaire_questions>

=cut

__PACKAGE__->table("questionnaire_questions");

=head1 ACCESSORS

=head2 questionnaire_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 question_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rank

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "questionnaire_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "question_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "rank",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</questionnaire_id>

=item * L</question_id>

=back

=cut

__PACKAGE__->set_primary_key("questionnaire_id", "question_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<questionnaire_id_rank_unique>

=over 4

=item * L</questionnaire_id>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint("questionnaire_id_rank_unique", ["questionnaire_id", "rank"]);

=head1 RELATIONS

=head2 question

Type: belongs_to

Related object: L<My::App::Schema::Result::Question>

=cut

__PACKAGE__->belongs_to(
  "question",
  "My::App::Schema::Result::Question",
  { question_id => "question_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 questionnaire

Type: belongs_to

Related object: L<My::App::Schema::Result::Questionnaire>

=cut

__PACKAGE__->belongs_to(
  "questionnaire",
  "My::App::Schema::Result::Questionnaire",
  { questionnaire_id => "questionnaire_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 15:05:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YbfCWog/5Ktvs/1AYyDeWg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/home/tai/perl5/perlbrew/perls/perl-5.34.0/lib/site_perl/5.34.0/My/App/Schema/Result/QuestionnaireQuestion.pm'


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
