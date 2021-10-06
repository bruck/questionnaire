use utf8;
package My::App::Schema::Result::QuestionnaireAnswer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

My::App::Schema::Result::QuestionnaireAnswer

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

=head1 TABLE: C<questionnaire_answer>

=cut

__PACKAGE__->table("questionnaire_answer");

=head1 ACCESSORS

=head2 questionnaire_answer_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'text'
  is_nullable: 1

=head2 questionnaire_id

  data_type: 'integer'
  is_nullable: 1

=head2 answered_at

  data_type: 'text'
  default_value: current_timestamp
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "questionnaire_answer_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "text", is_nullable => 1 },
  "questionnaire_id",
  { data_type => "integer", is_nullable => 1 },
  "answered_at",
  {
    data_type     => "text",
    default_value => \"current_timestamp",
    is_nullable   => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</questionnaire_answer_id>

=back

=cut

__PACKAGE__->set_primary_key("questionnaire_answer_id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 15:05:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:US9Ao/JmcvGwQKDSnCuZ7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
