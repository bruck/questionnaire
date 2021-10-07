use utf8;
package TPS::Questionnaire::Schema::Result::Questionnaire;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TPS::Questionnaire::Schema::Result::Questionnaire

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

=head1 TABLE: C<questionnaire>

=cut

__PACKAGE__->table("questionnaire");

=head1 ACCESSORS

=head2 questionnaire_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  default_value: (empty string)
  is_nullable: 0

=head2 is_published

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "questionnaire_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "text", default_value => "", is_nullable => 0 },
  "is_published",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</questionnaire_id>

=back

=cut

__PACKAGE__->set_primary_key("questionnaire_id");

=head1 RELATIONS

=head2 questionnaire_answers

Type: has_many

Related object: L<TPS::Questionnaire::Schema::Result::QuestionnaireAnswer>

=cut

__PACKAGE__->has_many(
  "questionnaire_answers",
  "TPS::Questionnaire::Schema::Result::QuestionnaireAnswer",
  { "foreign.questionnaire_id" => "self.questionnaire_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 questionnaire_question

Type: has_many

Related object: L<TPS::Questionnaire::Schema::Result::QuestionnaireQuestion>

=cut

__PACKAGE__->has_many(
  "questionnaire_question",
  "TPS::Questionnaire::Schema::Result::QuestionnaireQuestion",
  { "foreign.questionnaire_id" => "self.questionnaire_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6mZjm+7EW0DSP+VLT3WYKA

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
