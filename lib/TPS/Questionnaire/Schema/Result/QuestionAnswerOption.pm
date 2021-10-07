use utf8;
package TPS::Questionnaire::Schema::Result::QuestionAnswerOption;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TPS::Questionnaire::Schema::Result::QuestionAnswerOption

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

=head1 TABLE: C<question_answer_option>

=cut

__PACKAGE__->table("question_answer_option");

=head1 ACCESSORS

=head2 question_answer_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 option_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "question_answer_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "option_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</question_answer_id>

=item * L</option_id>

=back

=cut

__PACKAGE__->set_primary_key("question_answer_id", "option_id");

=head1 RELATIONS

=head2 option

Type: belongs_to

Related object: L<TPS::Questionnaire::Schema::Result::Option>

=cut

__PACKAGE__->belongs_to(
  "option",
  "TPS::Questionnaire::Schema::Result::Option",
  { option_id => "option_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 question_answer

Type: belongs_to

Related object: L<TPS::Questionnaire::Schema::Result::QuestionAnswer>

=cut

__PACKAGE__->belongs_to(
  "question_answer",
  "TPS::Questionnaire::Schema::Result::QuestionAnswer",
  { question_answer_id => "question_answer_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Gm8vVkp29iYeGNDcoIgx0A

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
