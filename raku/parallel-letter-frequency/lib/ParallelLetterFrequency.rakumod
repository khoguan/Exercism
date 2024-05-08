unit module ParallelLetterFrequency;

# Iteration 1
# Iteration 2
# Iteration 3

sub letter-frequencies (+@texts) is export {
    return letter-frequencies-v2(@texts);

    # v1: using Hash to manually count the frequencies
    sub letter-frequencies-v1(@texts) {
        my %counts;

        @texts>>.comb(/<alpha>/)>>.fc>>.&count-letters-freq();
        
        return %counts;

        sub count-letters-freq($letter) {
               %counts{$letter}++;
        } 
    }

    # v1: using Bag to count automatically, then turn the bag into a Hash.
    sub letter-frequencies-v2(@texts) {
        return @texts>>.comb(/<alpha>/)>>.fc>>.Slip.Bag.Hash;
    }
}
