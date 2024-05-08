unit module Luhn;

sub is-luhn-valid ($input) is export {

    if $input ~~ /<-[\d\ ]>/ { return False }
    if $input ~~ /^\s*\d\s*$/ { return False }

    my $sum = sum gather for $input.subst(/\s+/, '', :g).comb.reverse.kv -> $i, $n is copy {
        if $i mod 2 == 1 {
            $n += $n;
            if $n > 9 { $n -= 9 }
        }
        take $n;
    }

    return $sum %% 10;
}
