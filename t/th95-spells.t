use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::TH95::Spells;

use Encode;
use Path::Class qw(file);

my $spells = Toho::Replay::TH95::Spells->new();
plan tests => 2 * blocks;

run {
    my $block = shift;

    is $spells->opponent($block->level, $block->scene), $block->opponent, 'opponent';
    is $spells->card($block->level, $block->scene),     $block->card,     'card';
}

__END__
=== ok
--- level chomp
4
--- scene chomp
6
--- opponent chomp
鈴仙・優曇華院・イナバ
--- card chomp
波符「幻の月（インビジブルハーフムーン）」
=== ok
--- level chomp
7
--- scene chomp
5
--- opponent chomp
十六夜 咲夜
--- card chomp
空虚「インフレーションスクウェア」
=== ok
--- level chomp
3
--- scene chomp
5
--- opponent chomp
アリス・マーガトロイド
--- card chomp
呪符「ストロードールカミカゼ」
