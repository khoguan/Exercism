#!/usr/bin/env raku
say letter-frequencies("abbc", "ccd");

sub letter-frequencies (+@texts) is export {
    my %counts;

    @texts>>.comb>>.&count-letters-freq();
    
    return %counts;

    sub count-letters-freq($letter) {
        put "see '$letter'"; 
        return unless $letter ~~ /<alpha>/;
        %counts{$letter.fc}++;
    } 
}
