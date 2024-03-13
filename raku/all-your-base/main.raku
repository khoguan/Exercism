#!/usr/bin/env raku
use lib <./lib>;
use AllYourBase;

dd convert-base(bases => {from => 2, to => 10}, digits => [1, 0, 0, 1]);
dd convert-base(bases => {from => 10, to => 2}, digits => [9]);
