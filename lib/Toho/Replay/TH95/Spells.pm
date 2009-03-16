package Toho::Replay::TH95::Spells;

use Mouse;
use Carp::Clan;
use utf8;

__PACKAGE__->meta->make_immutable;

no Mouse;

my $opponents = [
    ["リグル・ナイトバグ", "ルーミア"],
    ["チルノ", "レティ・ホワイトロック"],
    ["アリス・マーガトロイド", "上白沢 慧音"],
    ["鈴仙・優曇華院・イナバ", "メディスン・メランコリー", "因幡 てゐ"],
    ["紅 美鈴", "パチュリー・ノーレッジ"],
    ["橙", "魂魄 妖夢"],
    ["十六夜 咲夜", "レミリア・スカーレット"],
    ["八雲 藍", "西行寺 幽々子"],
    ["八意 永琳", "蓬莱山 輝夜"],
    ["小野塚 小町", "四季映姫・ヤマザナドゥ"],
    ["フランドール・スカーレット", "八雲 紫", "藤原 妹紅", "伊吹 萃香"]
];

my $opponent_maps = {
    # level 1
    1 => {
        1 => $opponents->[0][0],
        2 => $opponents->[0][1],
        3 => $opponents->[0][0],
        4 => $opponents->[0][1],
        5 => $opponents->[0][0],
        6 => $opponents->[0][1],
    },
    # level 2
    2 => {
        1 => $opponents->[1][0],
        2 => $opponents->[1][1],
        3 => $opponents->[1][0],
        4 => $opponents->[1][1],
        5 => $opponents->[1][0],
        6 => $opponents->[1][1],
    },
    # level 3
    3 => {
        1 => $opponents->[2][0],
        2 => $opponents->[2][1],
        3 => $opponents->[2][0],
        4 => $opponents->[2][1],
        5 => $opponents->[2][0],
        6 => $opponents->[2][1],
        7 => $opponents->[2][0],
        8 => $opponents->[2][1],
    },
    # level 4
    4 => {
        1 => $opponents->[3][0],
        2 => $opponents->[3][1],
        3 => $opponents->[3][2],
        4 => $opponents->[3][0],
        5 => $opponents->[3][1],
        6 => $opponents->[3][0],
        7 => $opponents->[3][1],
        8 => $opponents->[3][2],
        9 => $opponents->[3][0],
    },
    # level 5
    5 => {
        1 => $opponents->[4][0],
        2 => $opponents->[4][1],
        3 => $opponents->[4][0],
        4 => $opponents->[4][1],
        5 => $opponents->[4][0],
        6 => $opponents->[4][1],
        7 => $opponents->[4][0],
        8 => $opponents->[4][1],
    },
    # level 6
    6 => {
        1 => $opponents->[5][0],
        2 => $opponents->[5][1],
        3 => $opponents->[5][0],
        4 => $opponents->[5][1],
        5 => $opponents->[5][0],
        6 => $opponents->[5][1],
        7 => $opponents->[5][0],
        8 => $opponents->[5][1],
    },
    # level 7
    7 => {
        1 => $opponents->[6][0],
        2 => $opponents->[6][1],
        3 => $opponents->[6][0],
        4 => $opponents->[6][1],
        5 => $opponents->[6][0],
        6 => $opponents->[6][1],
        7 => $opponents->[6][0],
        8 => $opponents->[6][1],
    },
    # level 8
    8 => {
        1 => $opponents->[7][0],
        2 => $opponents->[7][1],
        3 => $opponents->[7][0],
        4 => $opponents->[7][1],
        5 => $opponents->[7][0],
        6 => $opponents->[7][1],
        7 => $opponents->[7][0],
        8 => $opponents->[7][1],
    },
    # level 9
    9 => {
        1 => $opponents->[8][0],
        2 => $opponents->[8][1],
        3 => $opponents->[8][0],
        4 => $opponents->[8][1],
        5 => $opponents->[8][0],
        6 => $opponents->[8][1],
        7 => $opponents->[8][0],
        8 => $opponents->[8][1],
    },
    # level 10
    10 => {
        1 => $opponents->[9][0],
        2 => $opponents->[9][1],
        3 => $opponents->[9][0],
        4 => $opponents->[9][1],
        5 => $opponents->[9][0],
        6 => $opponents->[9][1],
        7 => $opponents->[9][0],
        8 => $opponents->[9][1],
    },
    # level Extra
    EX => {
        1 => $opponents->[10][0],
        2 => $opponents->[10][0],
        3 => $opponents->[10][1],
        4 => $opponents->[10][1],
        5 => $opponents->[10][2],
        6 => $opponents->[10][2],
        7 => $opponents->[10][3],
        8 => $opponents->[10][3],
    },
};

# スペルカード一覧
my $cards = {
    # level 1
    1 => {
        1 => "",
        2 => "",
        3 => "蛍符「地上の恒星」",
        4 => "闇符「ダークサイドオブムーン」",
        5 => "蝶符「バタフライストーム」",
        6 => "夜符「ミッドナイトバード」",
    },
    # level 2
    2 => {
        1 => "",
        2 => "",
        3 => "雪符「ダイヤモンドブリザード」",
        4 => "寒符「コールドスナップ」",
        5 => "凍符「マイナスK」",
        6 => "冬符「ノーザンウイナー」",
    },
    # level 3
    3 => {
        1 => "",
        2 => "光符「アマテラス」",
        3 => "操符「ドールズインシー」",
        4 => "包符「昭和の雨」",
        5 => "呪符「ストロードールカミカゼ」",
        6 => "葵符「水戸の光圀」",
        7 => "赤符「ドールミラセティ」",
        8 => "倭符「邪馬台の国」",
    },
    # level 4
    4 => {
        1 => "",
        2 => "霧符「ガシングガーデン」",
        3 => "脱兎「フラスターエスケープ」",
        4 => "散符「朧月花栞（ロケット・イン・ミスト）」",
        5 => "毒符「ポイズンブレス」",
        6 => "波符「幻の月（インビジブルハーフムーン）」",
        7 => "譫妄「イントゥデリリウム」",
        8 => "借符「大穴牟遅様の薬」",
        9 => "狂夢「風狂の夢（ドリームワールド）」",
    },
    # level 5
    5 => {
        1 => "",
        2 => "日＆水符「ハイドロジェナスプロミネンス」",
        3 => "華符「彩光蓮華掌」",
        4 => "水＆火符「フロギスティックレイン」",
        5 => "彩翔「飛花落葉」",
        6 => "月＆木符「サテライトヒマワリ」",
        7 => "彩華「虹色太極拳」",
        8 => "日＆月符「ロイヤルダイヤモンドリング」",
    },
    # level 6
    6 => {
        1 => "",
        2 => "人智剣「天女返し」",
        3 => "星符「飛び重ね鱗」",
        4 => "妄執剣「修羅の血」",
        5 => "鬼神「鳴動持国天」",
        6 => "天星剣「涅槃寂静の如し」",
        7 => "化猫「橙」",
        8 => "四生剣「衆生無性の響き」",
    },
    # level 7
    7 => {
        1 => "",
        2 => "魔符「全世界ナイトメア」",
        3 => "時符「トンネルエフェクト」",
        4 => "紅符「ブラッディマジックスクウェア」",
        5 => "空虚「インフレーションスクウェア」",
        6 => "紅蝙蝠「ヴァンピリッシュナイト」",
        7 => "銀符「パーフェクトメイド」",
        8 => "神鬼「レミリアストーカー」",
    },
    # level 8
    8 => {
        1 => "",
        2 => "幽雅「死出の誘蛾灯」 ",
        3 => "密符「御大師様の秘鍵」 ",
        4 => "蝶符「鳳蝶紋の死槍」 ",
        5 => "行符「八千万枚護摩」 ",
        6 => "死符「酔人の生、死の夢幻」 ",
        7 => "超人「飛翔役小角」 ",
        8 => "「死蝶浮月」",
    },
    # level 9
    9 => {
        1 => "",
        2 => "新難題「月のイルメナイト」 ",
        3 => "薬符「胡蝶夢丸ナイトメア」 ",
        4 => "新難題「エイジャの赤石」 ",
        5 => "練丹「水銀の海」 ",
        6 => "新難題「金閣寺の一枚天井」 ",
        7 => "秘薬「仙香玉兎」 ",
        8 => "新難題「ミステリウム」",
    },
    # level 10
    10 => {
        1 => "",
        2 => "嘘言「タン・オブ・ウルフ」 ",
        3 => "死歌「八重霧の渡し」 ",
        4 => "審判「十王裁判」 ",
        5 => "古雨「黄泉中有の旅の雨」",
        6 => "審判「ギルティ・オワ・ノットギルティ」 ",
        7 => "死価「プライス・オブ・ライフ」 ",
        8 => "審判「浄頗梨審判 -射命丸文-」",
    },
    # level Extra
    EX => {
        1 => "禁忌「フォービドゥンフルーツ」",
        2 => "禁忌「禁じられた遊び」",
        3 => "境符「色と空の境界」",
        4 => "境符「波と粒の境界」",
        5 => "貴人「サンジェルマンの忠告」",
        6 => "蓬莱「瑞江浦嶋子と五色の瑞亀」",
        7 => "鬼気「濠々迷霧」",
        8 => "「百万鬼夜行」"
    },
};

sub opponent_from_level_and_scene {
    my ( $self, $level, $scene ) = @_;

    return $opponent_maps->{$level}->{$scene};
}

sub card_from_level_and_scene {
    my ( $self, $level, $scene ) = @_;

    return $cards->{$level}->{$scene};
}

1;
__END__

=encoding utf8

=head1 NAME

Toho::Replay::TH95::Spells - 東方文花帖のスペル.

=head1 SYNOPSIS

  use Toho::Replay::TH95;

  my $spell = Toho::Replay::TH95::Spells->new();
  my $opponent = $spell->opponent(7, 7); # => 十六夜 咲夜
  my $card     = $spell->card(7, 7); # => 銀符「パーフェクトメイド」

=head1 DESCRIPTION

東方文花帖のスペルカードと使用者です。

=head1 METHODS

=head2 parse

与えられた文字列を東方文花帖の replay file として parse します。

=head1 ACCESSOR

=head2 opponent

=head2 card

=head1 AUTHOR

Daisuke Komatsu E<lt>vkg.taro@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
