my class X::Bowling::GameOver is Exception {
    method message {'Cannot roll after game is over'}
}

my class X::Bowling::GameInProgress is Exception {
    method message {'Score cannot be taken until the end of the game'}
}

my class X::Bowling::TooManyPins is Exception {
    method message {'Pin count exceeds pins on the lane'}
}

my class X::Bowling::NegativePins is Exception {
    method message {'Negative roll is invalid'}
}

class Bowling {
    # 10 frames, 2 score slots for each of 0th to 8th frame,
    # but 3 score slots for the 9th(i.e. last) frame 
    has @!scores = 0 xx 21;
    has $!cur-idx = 0;
    has $!game-over = False;

    method roll ($pins) {
        if $!game-over { X::Bowling::GameOver.new.throw     } 
        if $pins < 0   { X::Bowling::NegativePins.new.throw }
        if $pins > 10  { X::Bowling::TooManyPins.new.throw  }

        @!scores[$!cur-idx] = $pins;

        if $!cur-idx < 18 {  # before the last frame
            if $!cur-idx %% 2 {  # first roll for each frame
                if $pins == 10 { # strike!
                    @!scores[++$!cur-idx] = 0;
                }
            } else {             # second roll for each frame
                check-second-roll($pins, $!cur-idx);
            }
        } else {  #  $!cur-idx >= 18   # in last frame
            if $!cur-idx == 20 {
                if @!scores[18] == 10
                && @!scores[19] != 10
                && @!scores[19] + @!scores[20] > 10 {
                    X::Bowling::TooManyPins.new.throw;
                } 
                $!game-over = True;
                return;
            } elsif $!cur-idx == 19 {
                if @!scores[18] != 10 { check-second-roll($pins, 19); }
                if $pins + @!scores[18] < 10 {  # open frame, then game over
                    $!game-over = True;
                    return;
                }
            }
        }

        ++$!cur-idx;

        return;

        # helping routine
        sub check-second-roll(\second-roll, \cur-idx) {
            if second-roll + @!scores[cur-idx - 1] > 10 {
                    X::Bowling::TooManyPins.new.throw;
            } 
        }
    }

    method score {
        if not $!game-over { X::Bowling::GameInProgress.new.throw };
        my $total = 0;
        loop (my $i = 0; $i < 18; ++$i) {

            $total += (my $cur-score = @!scores[$i]);

            # strike
            if $i %% 2 && $cur-score == 10 {
                $total += (my $next-score = @!scores[$i+2]);
                if $next-score == 10 && $i < 16 {  # double strike!
                    $total += @!scores[$i+4];
                } else {                # single strike
                    $total += @!scores[$i+3];
                }
                ++$i;
            } 
            # spare
            elsif $i mod 2 == 1 && $cur-score + @!scores[$i-1] == 10 {
                $total += @!scores[$i+1];
            }
        }
        $total += [+] @!scores[18..20];
        return $total; 
    }
}
