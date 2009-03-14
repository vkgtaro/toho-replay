package Toho::Replay::TH9;

use Mouse;
use Carp::Clan;
use utf8;

with 'Toho::Replay::Parseable';

has label     => ( is => 'ro', default => '東方花映塚' );
has player    => ( is => 'rw', isa     => 'Str' );
has date      => ( is => 'rw', isa     => 'Str' );
has character => ( is => 'rw', isa     => 'Str' );
has score     => ( is => 'rw', isa     => 'Int' );
has level     => ( is => 'rw', isa     => 'Str' );
has mode      => ( is => 'rw', isa     => 'Str' );
has strength  => ( is => 'rw', isa     => 'Str' );
has version   => ( is => 'rw', isa     => 'Str' );
has comment   => ( is => 'rw', isa     => 'Str' );

__PACKAGE__->meta->make_immutable;

no Mouse;

sub BUILD {
    my ( $self, $args ) = @_;
    $self->parse( $args->{str} );
    return $self;
}

sub parse {
    my ( $self, $str ) = @_;

    unless ( $str =~ m{T9RP}xms ) {
        croak 'This file is not th9 replay file!';
    }

    $str = decode( 'cp932', $str );
    $str =~ s{\x0D\x0A|\x0D|\x0A}{\n}xmsg;
    foreach my $line ( split "\n", $str ) {
        next if $self->set_accessor_if_get_value( 'player',    "プレイヤー名",       $line );
        next if $self->set_accessor_if_get_value( 'date',      "プレイ時刻",         $line );
        next if $self->set_accessor_if_get_value( 'character', "使用キャラ",         $line );
        next if $self->set_accessor_if_get_value( 'level',     "難易度",             $line );
        next if $self->set_accessor_if_get_value( 'score',     "スコア",             $line );
        next if $self->set_accessor_if_get_value( 'mode',      "モード",             $line );
        next if $self->set_accessor_if_get_value( 'strength',  "初期体力",           $line );
        next if $self->set_accessor_if_get_value( 'version',   "ゲームのバージョン", $line );

        if ( $line =~ m{USER}xms ) {
            my $comment = $line;
            $comment =~ s{[\x00-\x09]|[\x0B-\x1F]|\x7F}{}xmsg;
            $comment =~ s{USER}{}xms;
            $self->comment($comment);
        }
    }

}

1;
__END__

=encoding utf8

=head1 NAME

Toho::Replay::TH9 - 東方花映塚のリプレイ.

=head1 SYNOPSIS

  use Toho::Replay::TH9;

  my $th9 = Toho::Replay::TH9->new();
  $th9->parse($replay_string);

=head1 DESCRIPTION

東方花映塚のリプレイファイルを表すクラスです。

=head1 METHODS

=head2 parse

与えられた文字列を東方花映塚の replay file として parse します。

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
