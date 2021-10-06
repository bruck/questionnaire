use utf8;
package My::App::Schema::Result::Question;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

My::App::Schema::Result::Question

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

Related object: L<My::App::Schema::Result::Option>

=cut

__PACKAGE__->has_many(
  "options",
  "My::App::Schema::Result::Option",
  { "foreign.question_id" => "self.question_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 questionnaire_questions

Type: has_many

Related object: L<My::App::Schema::Result::QuestionnaireQuestion>

=cut

__PACKAGE__->has_many(
  "questionnaire_questions",
  "My::App::Schema::Result::QuestionnaireQuestion",
  { "foreign.question_id" => "self.question_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 15:05:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6h4y7cm8EFG6wmJv9WF4cQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
