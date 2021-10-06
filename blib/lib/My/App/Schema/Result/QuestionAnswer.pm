use utf8;
package My::App::Schema::Result::QuestionAnswer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

My::App::Schema::Result::QuestionAnswer

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

=head1 TABLE: C<question_answer>

=cut

__PACKAGE__->table("question_answer");

=head1 ACCESSORS

=head2 question_answer_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 questionnaire_answer_id

  data_type: 'integer'
  is_nullable: 1

=head2 question_id

  data_type: 'integer'
  is_nullable: 1

=head2 answer_text

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "question_answer_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "questionnaire_answer_id",
  { data_type => "integer", is_nullable => 1 },
  "question_id",
  { data_type => "integer", is_nullable => 1 },
  "answer_text",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</question_answer_id>

=back

=cut

__PACKAGE__->set_primary_key("question_answer_id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 15:05:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EllQOedM7WqBVr0b+ABezQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
