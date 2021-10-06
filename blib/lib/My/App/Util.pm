use utf8;
use strict;
use warnings;
package My::App::Util;

use base 'Exporter';
use namespace::autoclean;

use Carp 'croak';
use Module::Runtime 'is_module_name';

our @EXPORT_OK = qw( mk_module_name );

sub mk_module_name {
    my ( $string, $prefix ) = @_;

    $string =
        join '',
        map ucfirst,
        split /\s|_/, lc $string;

    if ( $prefix ) {
        $string = join '::', $prefix, $string;
    }

    if ( not is_module_name($string) ) {
        croak sprintf(
            '"%s" could not be turned into a valid module name',
            $_[0],
        );
    }

    return $string;
}

1;
