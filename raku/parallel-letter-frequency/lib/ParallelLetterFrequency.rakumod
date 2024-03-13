unit module ParallelLetterFrequency;

# Iteration 1

sub letter-frequencies (+@texts) is export {
    my %counts;

    @texts>>.comb>>.&count-letters-freq();
    
    return %counts;

    sub count-letters-freq($letter) {
           return unless $letter ~~ /<alpha>/;
           %counts{$letter.fc}++;
    } 
}
