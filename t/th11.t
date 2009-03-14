use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::TH11;

use Encode;
use Path::Class qw(file);

my $str  = file('t/replays/th11_01.rpy')->slurp();
$str = decode( 'cp932', $str );
my @keys = qw/label player date character score level stage slow_rate version comment/;

plan tests => @keys * blocks;

run {
    my $block = shift;

    my $replay = Toho::Replay::TH11->new( str => $str );

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
東方地霊殿
--- player chomp
PETEN4!
--- date chomp
08/08/29 02:48
--- character chomp
ReimuA
--- score chomp
47821502
--- level chomp
Normal
--- stage chomp
All Clear
--- slow_rate chomp
0.12
--- version chomp
1.00a
--- comment chomp
コメントを書けます

