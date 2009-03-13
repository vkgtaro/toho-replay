package Toho::Replay::Parser;

use Mouse::Role;
use Encode;

requires qw(parse);

sub set_accessor_if_get_value {
    my ( $self, $accessor, $key, $line ) = @_;

    if ( my $value = $self->get_value( $key, $line ) ) {

        # FIXME: 空白除去は別なところでやる。ここだとハードコーディングに……
        if (   $accessor ne 'date'
            && $accessor ne 'strength'
            && $accessor ne 'version' )
        {
            $value =~ s{\s}{}xmsg;
        }

        $self->$accessor($value);
        return 1;
    }

}

sub get_value {
    my ( $self, $key, $line ) = @_;

    if ( $line =~ m{$key \t+ (.*)}xms ) {
        my $value = $1;
        return $value;
    }
}

1;
__END__

=encoding utf8

=head1 NAME

Toho::Replay::Role - Role for Toho::Replay.

=head1 SYNOPSIS

  use Toho::Replay::Role;

=head1 DESCRIPTION

Toho::Replay の Role です。

=head1 AUTHOR

Daisuke Komatsu E<lt>vkg.taro@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
