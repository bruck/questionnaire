use utf8;
package My::App::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-06 19:30:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+YqtHDdRtreX8NEy52adJw

use FindBin '$Bin';
use Path::Tiny 'path';

sub maybe_deploy {
    my $self = shift;
    my $dbh  = $self->storage->_get_dbh;

    local $dbh->{RaiseError} = 1;
    local $@;
    eval {
        my $sth = $dbh->prepare('SELECT * FROM questionnaire;');
        $sth->execute;
        $sth->fetchrow_arrayref;
    };
    return unless $@;

    $self->deploy;
}

1;
