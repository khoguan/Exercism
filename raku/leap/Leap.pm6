unit module Leap;

sub is-leap-year ($year) is export {
    $year %% 400 or
    $year %% 4 && $year !%% 100;
}
