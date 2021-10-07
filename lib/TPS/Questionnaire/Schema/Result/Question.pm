use utf8;
package TPS::Questionnaire::Schema::Result::Question;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TPS::Questionnaire::Schema::Result::Question

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

=head1 TABLE: C<question>

=cut

__PACKAGE__->table("question");

=head1 ACCESSORS

=head2 question_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 question_text

  data_type: 'text'
  is_nullable: 1

=head2 question_type

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "question_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "question_text",
  { data_type => "text", is_nullable => 1 },
  "question_type",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</question_id>

=back

=cut

__PACKAGE__->set_primary_key("question_id");

=head1 RELATIONS

=head2 options

Type: has_many

Related object: L<TPS::Questionnaire::Schema::Result::Option>

=cut

__PACKAGE__->has_many(
  "options",
  "TPS::Questionnaire::Schema::Result::Option",
  { "foreign.question_id" => "self.question_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 question_answers

Type: has_many

Related object: L<TPS::Questionnaire::Schema::Result::QuestionAnswer>

=cut

__PACKAGE__->has_many(
  "question_answers",
  "TPS::Questionnaire::Schema::Result::QuestionAnswer",
  { "foreign.question_id" => "self.question_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 questionnaire_question

Type: has_many

Related object: L<TPS::Questionnaire::Schema::Result::QuestionnaireQuestion>

=cut

__PACKAGE__->has_many(
  "questionnaire_question",
  "TPS::Questionnaire::Schema::Result::QuestionnaireQuestion",
  { "foreign.question_id" => "self.question_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ba4HMsQv0uN3RaT7cdIuNQ

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
