on *:text:~pickpocket*:#: {
  if (%flood [ $+ [ $nick ] ]) { return }
  set -u3 %flood [ $+ [ $nick ] ] $true
  if (!$2) { halt }
  if ($2 ison $Chan) { 
    msg $chan 4 $+ I tiptoe up to $2 quietly...
    .timer 1 2 msg $chan 4 slowly reach inside $2 $+ 's pocket and find...
    var %item = $rand(1,30)
    if (%item == 1) .timer 1 4 msg $chan 4 $+ A half eaten lollypop
    if (%item == 2) .timer 1 4 msg $chan 4 $+ A 50 dollar bill!
    if (%item == 3) .timer 1 4 msg $chan 4 $+ A wallet! but it's empty D:  
    if (%item == 4) .timer 1 4 msg $chan 4 $+ A wad of lint :o
    if (%item == 5) .timer 1 4 msg $chan 4 $+ An ipod Touch Sc00r!
    if (%item == 6) .timer 1 4 msg $chan 4 $+ Cigarettes :/
    if (%item == 7) .timer 1 4 msg $chan 4 $+ A comb, is that a bug?
    if (%item == 8) .timer 1 4 msg $chan 4 $+ A plastic ring :(
    if (%item == 9) .timer 1 4 msg $chan 4 $+ A pocket protector. O:
    if (%item == 10) .timer 1 4 msg $chan 4 $+ Chewed up Bubble gum!
    if (%item == 11) .timer 1 4 msg $chan 4 $+ $2 $+ 's pocket was empty
    if (%item == 12) .timer 1 4 msg $chan 4 $+ Car keys! ~steals the car~
    if (%item == 13) .timer 1 4 msg $chan 4 $+ A parking ticket, let's just put that back.
    if (%item == 14) .timer 1 4 msg $chan 4 $+ A New Kids On The Block Tape?!?!?!
    if (%item == 15) .timer 1 4 msg $chan 4 $+ A buy one get one free coupon for OMG!!!
    if (%item == 16) .timer 1 4 msg $chan 4 $+ A dog treat, it's half eaten! Are those human teeth marks?
    if (%item == 17) .timer 1 4 msg $chan 4 $+ A lego. :/
    if (%item == 18) .timer 1 4 msg $chan 4 $+ NERD GLASSES!!!
    if (%item == 19) .timer 1 4 msg $chan 4 $+ A 1 megabyte RAM stick?
    if (%item == 20) .timer 1 4 msg $chan 4 $+ EwWwWwWwWwWwW!!! ~presses Alt+F4~
    if (%item == 21) .timer 1 4 msg $chan 4 $+ An e-book, OMG you sicko x|
    if (%item == 22) .timer 1 4 msg $chan 4 $+ A dollar. :\
    if (%item == 23) .timer 1 4 msg $chan 4 $+ A smurf doll? Wtf?
    if (%item == 24) .timer 1 4 msg $chan 4 $+ Half of a banana.
    if (%item == 25) .timer 1 4 msg $chan 4 $+ A lint encrusted pop tart.
    if (%item == 26) .timer 1 4 msg $chan 4 $+ Oh! Oh! I'm sorry, I meant to go into your POCKET! :x
    if (%item == 27) .timer 1 4 msg $chan 4 $+ It's empty...
    if (%item == 28) .timer 1 4 msg $chan 4 $+ Plans to take over the world, huh, they're pretty good!
    if (%item == 29) .timer 1 4 msg $chan 4 $+ A love poem.
    if (%item == 30) .timer 1 4 msg $chan 4 $+ A rusted spoon.
  }
  else {
    msg $chan 4 $+ $Nick $2 is not in this room.
  }
}
