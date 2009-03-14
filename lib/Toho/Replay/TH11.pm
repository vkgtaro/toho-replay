package Toho::Replay::TH11;

use Mouse;
use Carp::Clan;
use utf8;

with 'Toho::Replay::Parseable';

has label     => ( is => 'ro', default => '東方地霊殿' );
has player    => ( is => 'rw', isa     => 'Str' );
has date      => ( is => 'rw', isa     => 'Str' );
has character => ( is => 'rw', isa     => 'Str' );
has score     => ( is => 'rw', isa     => 'Int' );
has level     => ( is => 'rw', isa     => 'Str' );
has stage     => ( is => 'rw', isa     => 'Str' );
has slow_rate => ( is => 'rw', isa     => 'Str' );
has version   => ( is => 'rw', isa     => 'Str' );
has comment   => ( is => 'rw', isa     => 'Str' );

__PACKAGE__->meta->make_immutable;

no Mouse;

sub parse {
    my ( $self, $str ) = @_;

    unless ( $str =~ m{t11r}xms ) {
        croak 'This file is not th11 replay file!';
    }

    $str =~ s{\x0D\x0A|\x0D|\x0A}{\n}xmsg;
    foreach my $line ( split "\n", $str ) {
        next if $self->set_accessor_if_get_value( 'player',    "Name",      $line );
        next if $self->set_accessor_if_get_value( 'date',      "Date",      $line );
        next if $self->set_accessor_if_get_value( 'character', "Chara",     $line );
        next if $self->set_accessor_if_get_value( 'level',     "Rank",      $line );
        next if $self->set_accessor_if_get_value( 'score',     "Score",     $line );
        next if $self->set_accessor_if_get_value( 'stage',     "Stage",     $line );
        next if $self->set_accessor_if_get_value( 'slow_rate', qr/Slow Rate/, $line );
        next if $self->set_accessor_if_get_value( 'version',   "Version",   $line );

        if ( $line =~ m{USER}xms ) {
            my $comment = $line;
            $comment =~ s{[\x00-\x09]|[\x0B-\x1F]|\x7F}{}xmsg;
            $comment =~ s{USER \s}{}xms;
            $self->comment($comment);
        }
    }

    foreach my $key (qw/player character level score version/) {
        $self->$key( $self->trim_white_space($self->$key) );
        $self->$key( $self->trim_controll_code($self->$key) );
    }
}

1;
__END__

=encoding utf8

=head1 NAME

Toho::Replay::TH11 - 東方地霊殿のリプレイ.

=head1 SYNOPSIS

  use Toho::Replay::TH11;

  my $th11 = Toho::Replay::TH11->new();
  $th11->parse($replay_string);

=head1 DESCRIPTION

東方地霊殿のリプレイファイルを表すクラスです。

=head1 METHODS

=head2 parse

与えられた文字列を東方地霊殿の replay file として parse します。

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
