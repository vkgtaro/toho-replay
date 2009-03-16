use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::Bridge;

use Path::Class qw(file);

plan tests => 3 * blocks;

my $factory = Toho::Replay::Bridge->new;

run {
    my $block = shift;

    my $handle = file($block->file)->openr;
    my $string = file($block->file)->slurp;

    my $replay_from_file   = $factory->from_file( $block->file );
    my $replay_from_handle = $factory->from_handle( $handle );
    my $replay_from_string = $factory->from_string( $string );

    is $replay_from_file->label,   $block->label, 'file';
    is $replay_from_handle->label, $block->label, 'handle';
    is $replay_from_string->label, $block->label, 'string';
}

__END__
=== th8
--- file chomp
t/replays/th8_01.rpy
--- label chomp
東方永夜抄
=== th9
--- file chomp
t/replays/th9_01.rpy
--- label chomp
東方花映塚
=== th10
--- file chomp
t/replays/th10_01.rpy
--- label chomp
東方風神録
