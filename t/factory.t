use strict;
use warnings;
use utf8;

use Test::Base;

use Toho::Replay::Factory;

use Path::Class qw(file);

plan tests => 3 * blocks;

my $factory = Toho::Replay::Factory->new;

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
=== ok
--- file chomp
t/replays/th8_01.rpy
--- label chomp
東方永夜抄
