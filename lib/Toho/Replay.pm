package Toho::Replay;

use Mouse;

our $VERSION = '0.01';

use Toho::Replay::Factory;

has 'factory' => (
    is      => 'rw',
    default => sub {
        Toho::Replay::Factory->new;
    },
);

has file => (
    is       => 'rw',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

no Mouse;

sub create {
    my ($self) = @_;

    my $file = $self->file;

    return $self->factory->from_handle($file)
        if UNIVERSAL::isa( $file, 'GLOB' )
            or ref( \$file ) eq 'GLOB';

    return $self->factory->from_file($file)
        if -f $file;

    return $self->factory->from_string($file);
}

1;

__END__

=encoding utf8

=head1 NAME

Toho::Replay - Parse a replay file of the Toho Project.

=head1 SYNOPSIS

  use Toho::Replay;

=head1 DESCRIPTION

Toho::Replay は、東方 Project のリプレイファイルを解析して、
キャラ名やスコアを取得するモジュールです。

=head1 AUTHOR

Daisuke Komatsu E<lt>vkg.taro@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
