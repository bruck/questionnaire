use utf8;
use strict;
use warnings;
package My::App::Util;

use base 'Exporter';

use Carp 'croak';
use Module::Runtime 'is_module_name';

our @EXPORT_OK = 'mk_module_name';

sub mk_module_name {
    my ( $string, $prefix ) = @_;

    my $class = join "",
        map ucfirst,
        split /_|\s+/,
        lc $string;
    $class = "$prefix\::$class" if $prefix;

    croak "Could not turn '$string' into a classname"
        unless is_module_name($class);

    return $class;
}

1;
