use strict;
use warnings;
use utf8;

use Test::Base;

use Encode;
use Toho::Replay::TH10;

use Path::Class qw(file);

my $str  = file('t/replays/th10_01.rpy')->slurp();
my @keys = qw/label player date character score level stage slow_rate version comment/;

plan tests => @keys * blocks;

run {
    my $block = shift;

    my $replay = Toho::Replay::TH10->new( str => $str );

    foreach my $key (@keys) {
        my $expected = $block->$key;
        if ( $key eq 'stage' ) {
            $expected =~ s/\x{301C}/\x{FF5E}/xmsg;
        }
        is $replay->$key, $expected, $key;
    }
}

__END__
=== ok
--- label chomp
東方風神録
--- player chomp
taro
--- date chomp
07/12/23 01:09
--- character chomp
ReimuB
--- score chomp
11856251
--- level chomp
Normal
--- stage chomp
1 〜 5
--- slow_rate chomp
0.00
--- version chomp
1.00a
--- comment chomp
テスト

