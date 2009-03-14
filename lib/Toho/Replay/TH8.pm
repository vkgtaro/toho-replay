package Toho::Replay::TH8;

use Mouse;
use Carp::Clan;
use utf8;

with 'Toho::Replay::Parseable';

has label      => ( is => 'ro', default => '東方永夜抄' );
has player     => ( is => 'rw', isa     => 'Str' );
has date       => ( is => 'rw', isa     => 'Str' );
has character  => ( is => 'rw', isa     => 'Str' );
has score      => ( is => 'rw', isa     => 'Int' );
has level      => ( is => 'rw', isa     => 'Str' );
has stage      => ( is => 'rw', isa     => 'Str' );
has miss       => ( is => 'rw', isa     => 'Int' );
has bomb       => ( is => 'rw', isa     => 'Int' );
has slow_rate  => ( is => 'rw', isa     => 'Str' );
has human_rate => ( is => 'rw', isa     => 'Str' );
has version    => ( is => 'rw', isa     => 'Str' );
has comment    => ( is => 'rw', isa     => 'Str' );

__PACKAGE__->meta->make_immutable;

no Mouse;

sub BUILD {
    my ( $self, $args ) = @_;
    $self->parse( $args->{str} );
    return $self;
}

sub parse {
    my ( $self, $str ) = @_;

    unless ( $str =~ m{T8RP}xms ) {
        croak 'This file is not th8 replay file!';
    }

    $str = decode( 'cp932', $str );
    $str =~ s{\x0D\x0A|\x0D|\x0A}{\n}xmsg;
    foreach my $line ( split "\n", $str ) {
        next if $self->set_accessor_if_get_value( 'player',     "プレイヤー名",       $line );
        next if $self->set_accessor_if_get_value( 'date',       "プレイ時刻",         $line );
        next if $self->set_accessor_if_get_value( 'character',  "キャラ名",           $line );
        next if $self->set_accessor_if_get_value( 'score',      "スコア",             $line );
        next if $self->set_accessor_if_get_value( 'level',      "難易度",             $line );
        next if $self->set_accessor_if_get_value( 'stage',      "最終ステージ",       $line );
        next if $self->set_accessor_if_get_value( 'miss',       "ミス回数",           $line );
        next if $self->set_accessor_if_get_value( 'bomb',       "ボム回数",           $line );
        next if $self->set_accessor_if_get_value( 'slow_rate',  "処理落ち率",         $line );
        next if $self->set_accessor_if_get_value( 'human_rate', "人間率",             $line );
        next if $self->set_accessor_if_get_value( 'version',    "ゲームのバージョン", $line );

        if ( $line =~ m{USER}xms ) {
            my $comment = $line;
            $comment =~ s{[\x00-\x09]|[\x0B-\x1F]|\x7F}{}xmsg;
            $comment =~ s{USER}{}xms;
            $self->comment($comment);
        }
    }

    $self->player( $self->trim_white_space($self->player) );
    $self->character( $self->trim_white_space($self->character) );
}

1;
__END__

=encoding utf8

=head1 NAME

Toho::Replay::TH8 - 東方永夜抄のリプレイ.

=head1 SYNOPSIS

  use Toho::Replay::TH8;

  my $th8 = Toho::Replay::TH8->new();
  $th8->parse($replay_string);

=head1 DESCRIPTION

東方永夜抄のリプレイファイルを表すクラスです。

=head1 METHODS

=head2 parse

与えられた文字列を東方永夜抄の replay file として parse します。

=head1 ACCESSOR

=head2 player

=head2 date

=head2 character

=head2 score

=head2 level

=head2 stage

=head2 miss

=head2 bomb

=head2 slow_rate

=head2 human_rate

=head2 version

=head2 comment

=head1 AUTHOR

Daisuke Komatsu E<lt>vkg.taro@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
