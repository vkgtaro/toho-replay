package TestForParseable;

use Mouse;

with 'Toho::Replay::Parseable';

has 'foo' => ( is => 'rw' );

__PACKAGE__->meta->make_immutable;
no Mouse;

sub parse {
    my ( $self, $str ) = @_;

    return 'dammy!';
}

1;

