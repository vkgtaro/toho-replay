use strict;
use warnings;
use utf8;

use lib q(t/lib);

use Test::More qw(no_plan);

use TestForParseable;

my $obj = TestForParseable->new();

ok $obj->set_accessor_if_get_value('foo', 'foo', 'foo bar');
is $obj->foo, 'bar', 'accessor foo';

is $obj->get_value(qr/hoge hoge/, 'hoge hoge fuga'), 'fuga', 'accessor foo';

is $obj->trim_white_space('hoge  '), 'hoge', 'trim white space';
is $obj->trim_controll_code("hoge\x00"), 'hoge', 'trim controll code';

