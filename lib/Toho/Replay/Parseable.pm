package Toho::Replay::Parseable;

use Mouse::Role;

requires qw(parse);

sub set_accessor_if_get_value {
    my ( $self, $accessor, $key, $line ) = @_;

    if ( my $value = $self->get_value( $key, $line ) ) {

        $self->$accessor($value);
        return 1;
    }

}

sub get_value {
    my ( $self, $key, $line ) = @_;

    if ( $line =~ m{$key \s+ (.*)}xms ) {
        my $value = $1;
        return $value;
    }
}

sub trim_white_space {
    my ( $self, $str ) = @_;
    $str =~ s{\s+}{}xmsg;
    $str;
}

sub trim_controll_code {
    my ( $self, $str ) = @_;
    $str =~ s{[\x00-\x09]|[\x0B-\x1F]|\x7F}{}xmsg;
    $str;
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
