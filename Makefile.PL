use inc::Module::Install;
name 'Toho-Replay';
all_from 'lib/Toho/Replay.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
