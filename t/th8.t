use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::TH8;

use Encode;
use Path::Class qw(file);

my $str  = file('t/replays/th8_01.rpy')->slurp();
$str = decode( 'cp932', $str );
my @keys = qw/label player date character score level stage miss bomb slow_rate human_rate version comment/;

plan tests => @keys * blocks;

run {
    my $block = shift;

    my $replay = Toho::Replay::TH8->new( str => $str );

    foreach my $key (@keys) {
        is $replay->$key, $block->$key, $key;
    }
}

__END__
=== ok
--- label chomp
東方永夜抄
--- player chomp
Taro
--- date chomp
2007/05/06 22:51:17
--- character chomp
魔理沙＆アリス
--- score chomp
1385570940
--- level chomp
Normal
--- stage chomp
Clear
--- miss chomp
6
--- bomb chomp
15
--- slow_rate chomp
0.043619%
--- human_rate chomp
36.04％
--- version chomp
1.00d
--- comment chomp
テスト
