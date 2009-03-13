use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::TH9;

use Path::Class qw(file);

my $str  = file('t/replays/th9_01.rpy')->slurp();
my @keys = qw/label player date character score level mode strength version comment/;

plan tests => @keys * blocks;

run {
    my $block = shift;

    my $replay = Toho::Replay::TH9->new( str => $str );

    foreach my $key (@keys) {
        is $replay->$key, $block->$key, $key;
    }
}

__END__
=== ok
--- label chomp
東方花映塚
--- player chomp
Taro
--- date chomp
07/04/30
--- character chomp
てゐ
--- score chomp
1385570940
--- level chomp
Hard
--- mode chomp
Story
--- strength chomp
5.0 vs 5.0
--- version chomp
東方花映塚 ver 1.00
--- comment chomp
テスト
