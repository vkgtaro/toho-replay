use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::TH95;

use Encode;
use Path::Class qw(file);

my $str  = file('t/replays/th95_01.rpy')->slurp();
$str = decode( 'cp932', $str );
my @keys = qw/label player date score level scene version comment/;

plan tests => @keys * blocks;

run {
    my $block = shift;

    my $replay = Toho::Replay::TH95->new( str => $str );

    foreach my $key (@keys) {
        is $replay->$key, $block->$key, $key;
    }
}

__END__
=== ok
--- label chomp
東方文花帖
--- player chomp
Taro
--- date chomp
06/03/11 18:40
--- score chomp
80870
--- level chomp
7
--- scene chomp
5
--- version chomp
1.02a
--- comment chomp
テスト
