use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay;

use Path::Class qw(file);

plan tests => 3 * blocks;

run {
    my $block = shift;

    my $path = $block->file;
    my $handle = file($block->file)->openr;
    my $string = file($block->file)->slurp;

    my $replay_from_file   = Toho::Replay->new( file => $path )->create;
    my $replay_from_handle = Toho::Replay->new( file => $handle )->create;
    my $replay_from_string = Toho::Replay->new( file => $string )->create;

    is $replay_from_file->label,   $block->label, 'file';
    is $replay_from_handle->label, $block->label, 'handle';
    is $replay_from_string->label, $block->label, 'string';
}

__END__
=== ok
--- file chomp
t/replays/th8_01.rpy
--- label chomp
東方永夜抄
