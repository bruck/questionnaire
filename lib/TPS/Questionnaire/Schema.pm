use utf8;
package TPS::Questionnaire::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+YqtHDdRtreX8NEy52adJw

use Path::Tiny qw(path);
use Try::Tiny;

=head1 NAME

TPS::Questionnaire::Schema - L<DBIx::Class::Schema> subclass for L<TPS::Questionnaire>

=head1 METHODS

=head2 maybe_deploy()

Attempts to determine whether the schema already exists in the database,
and if not, then calls L<DBIx::Class::Schema/deploy>.

=cut

sub maybe_deploy {
    my $self = shift;

    try {
        my $dbh = $self->storage->_get_dbh;
        local $dbh->{RaiseError} = 1;
        # The following should succeed if the schema is already deployed.
        $dbh->selectrow_array('SELECT * FROM questionnaire;');
    }
    catch {
        $self->deploy;
    }
}

1;
