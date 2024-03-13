unit module AllYourBase;

# iteration 3: use `Int.polymod()` to do the hard work

constant @errors = (
  'input base must be >= 2',
  'output base must be >= 2',
  'all digits must satisfy 0 <= d < input base',
);

sub convert-base ( :%bases!, :@digits! ) is export {
    # verify input data

    my ($from, $to) = %bases<from>, %bases<to>;
    die @errors[0] if $from < 2;
    die @errors[1] if $to   < 2;
    for @digits -> $digit {
        if not (0 <= $digit < $from) { die @errors[2] }
    }
    # firstly, convert old-base number to 10-base number
    my $old-base-seq := $from ** 0, $from ** 1, $from ** 2 ... *;
    my $ten-base-num = sum(@digits.reverse Z* $old-base-seq);
    if $ten-base-num == 0 { return (0,) }
    
    # convert to the number with new base
    my $dividend = $ten-base-num;
    my @new-digits;
    
    # use `Int.polymod`
    @new-digits = $dividend.polymod($to xx *).reverse;

    # to replace the following hard work
    #while ($dividend >= $to) {
    #    @new-digits.unshift: $dividend mod $to;
    #    $dividend div= $to;
    #}
    #if $dividend > 0 { @new-digits.unshift: $dividend }

    return @new-digits.List;
}
