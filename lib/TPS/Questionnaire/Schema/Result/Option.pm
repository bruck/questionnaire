use utf8;
package TPS::Questionnaire::Schema::Result::Option;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TPS::Questionnaire::Schema::Result::Option

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

=head1 TABLE: C<option>

=cut

__PACKAGE__->table("option");

=head1 ACCESSORS

=head2 option_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 question_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 option_text

  data_type: 'text'
  is_nullable: 1

=head2 option_rank

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "option_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "question_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "option_text",
  { data_type => "text", is_nullable => 1 },
  "option_rank",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</option_id>

=back

=cut

__PACKAGE__->set_primary_key("option_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<question_id_option_rank_unique>

=over 4

=item * L</question_id>

=item * L</option_rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "question_id_option_rank_unique",
  ["question_id", "option_rank"],
);

=head1 RELATIONS

=head2 question

Type: belongs_to

Related object: L<TPS::Questionnaire::Schema::Result::Question>

=cut

__PACKAGE__->belongs_to(
  "question",
  "TPS::Questionnaire::Schema::Result::Question",
  { question_id => "question_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 question_answer_options

Type: has_many

Related object: L<TPS::Questionnaire::Schema::Result::QuestionAnswerOption>

=cut

__PACKAGE__->has_many(
  "question_answer_options",
  "TPS::Questionnaire::Schema::Result::QuestionAnswerOption",
  { "foreign.option_id" => "self.option_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 question_answers

Type: many_to_many

Composing rels: L</question_answer_options> -> question_answer

=cut

__PACKAGE__->many_to_many(
  "question_answers",
  "question_answer_options",
  "question_answer",
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yumPktgFcqDs5MwccwW0uQ
# These lines were loaded from '/home/tai/perl5/perlbrew/perls/perl-5.34.0/lib/site_perl/5.34.0/My/App/Schema/Result/Option.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package TPS::Questionnaire::Schema::Result::Option;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TPS::Questionnaire::Schema::Result::Option

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

=head1 TABLE: C<option>

=cut

__PACKAGE__->table("option");

=head1 ACCESSORS

=head2 option_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 question_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 option_text

  data_type: 'text'
  is_nullable: 1

=head2 option_rank

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "option_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "question_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "option_text",
  { data_type => "text", is_nullable => 1 },
  "option_rank",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</option_id>

=back

=cut

__PACKAGE__->set_primary_key("option_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<question_id_option_rank_unique>

=over 4

=item * L</question_id>

=item * L</option_rank>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "question_id_option_rank_unique",
  ["question_id", "option_rank"],
);

=head1 RELATIONS

=head2 question

Type: belongs_to

Related object: L<TPS::Questionnaire::Schema::Result::Question>

=cut

__PACKAGE__->belongs_to(
  "question",
  "TPS::Questionnaire::Schema::Result::Question",
  { question_id => "question_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 15:05:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:A9qtg5NjiZ3QibyntV3cMA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/home/tai/perl5/perlbrew/perls/perl-5.34.0/lib/site_perl/5.34.0/My/App/Schema/Result/Option.pm'


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
