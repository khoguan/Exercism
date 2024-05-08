#!/usr/bin/env raku
use lib <.>;
use ReverseString;

my $s = 'abcd';
put "'$s' reversed is &reverse-string($s)";
