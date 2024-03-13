unit module ParallelLetterFrequency;

# Iteration 1
# Iteration 2

sub letter-frequencies (+@texts) is export {
    my %counts;

    @texts>>.comb(/<alpha>/)>>.fc>>.&count-letters-freq();
    
    return %counts;

    sub count-letters-freq($letter) {
           %counts{$letter}++;
    } 
}
