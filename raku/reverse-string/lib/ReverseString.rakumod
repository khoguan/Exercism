unit module ReverseString;

sub reverse-string($string) is export {
    # We could have just used Raku's builtin Str.flip() to do all the dirty job.
    # But we won't learn much by doing that.

    return reverse-string-v1($string);
    
    # v1: using chars array
    sub reverse-string-v1($string) {
        if $string.chars == 0|1 { return $string }

        my @chars = $string.comb;
        my ($begin, $end) = 0, @chars.end;

        repeat { (@chars[$begin], @chars[$end]) = @chars[$end], @chars[$begin]; }
        while ++$begin < --$end;

        return @chars.join;
    }

    # v2: using Str.substr and Str.substr-rw
    sub reverse-string-v2($string is copy) {
        if $string.chars == 0|1 { return $string }

        my $res = $string;
        my ($begin, $end) = 0, $res.chars - 1;

        repeat {  # .substr-rw cannot work with list-swap trick
            my $temp = $res.substr($begin, 1);
            $res.substr-rw($begin, 1) = $res.substr($end, 1);
            $res.substr-rw($end, 1) = $temp;
        } while ++$begin < --$end;

        return $res;
    }
}
