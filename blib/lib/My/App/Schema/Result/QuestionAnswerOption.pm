use utf8;
package My::App::Schema::Result::QuestionAnswerOption;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

My::App::Schema::Result::QuestionAnswerOption

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
  is_nullable: 1

=head2 option_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "question_answer_id",
  { data_type => "integer", is_nullable => 1 },
  "option_id",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 15:05:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4EcUqo6Z2mMieFlPQ8MXXA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
