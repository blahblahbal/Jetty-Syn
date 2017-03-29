on *:CONNECT:{
  if ( %global.QP == $null ) { set %global.QP 1 }
  if ( %global.QP.logonly == $null ) { set %global.QP.logonly 1 }
  if ( %global.QP.log == $null ) { set %global.QP.log 3 }
  if ( %global.QP.respond == $null ) { set %global.QP.respond 4 }
  necho Quoteplus globals set.
}

on *:JOIN:#:{
  if ( $me == Jetty-Syn && $nick == blahblahbal ) {
    if ( %QP. [ $+ [ $chan ] ] == $null ) { set %QP. [ $+ [ $chan ] ] 0 }
    if ( %QP.logonly. [ $+ [ $chan ] ] == $null ) { set %QP.logonly. [ $+ [ $chan ] ] 0 }
    if ( %QP.log. [ $+ [ $chan ] ] == $null ) { set %QP.log. [ $+ [ $chan ] ] 3 }
    if ( %QP.respond.rate. [ $+ [ $chan ] ] == $null ) { set %QP.respond.rate. [ $+ [ $chan ] ] 4 }
    if ( %QP.intelligence. [ $+ [ $chan ] ] == $null ) { set %QP.intelligence. [ $+ [ $chan ] ] 2 }
  }
}


on *:TEXT:*:#:{
  if ( $strip($1) == Jetty-Syn $+ , || $strip($1) == Jetty-Syn $+ : ) {
    if ( $me == Jetty-Syn ) {
      if ( $nick isop $chan || $ulevel > 0 ) {
        if ( $2 == Quote+ ) {
          if ( $3 == off ) { /set %QP. [ $+ [ $chan ] ] 0 | /unset %QP.go | /unset %QP.write | /chanmsg Quote+ disabled. ( %QP. [ $+ [ $chan ] ] ) }
          elseif ( $3 == on ) { /set %QP. [ $+ [ $chan ] ] 1 | /unset %QP.go | /unset %QP.write | /set %QP.logonly. [ $+ [ $chan ] ] 0 | /chanmsg Quote+ enabled. ( %QP. [ $+ [ $chan ] ] ) - Quote+ log-only was also auto-disabled. ( %QP.logonly. [ $+ [ $chan ] ] ) }
          elseif ( $3 == status ) { /chanmsg Quote+ is currently $iif(%QP. [ $+ [ $chan ] ] == 1, enabled., disabled.) }
          elseif ( $3 == log-only ) {
            if ( $4 == on ) { /set %QP. [ $+ [ $chan ] ] 0 | /unset %QP.write | /set %QP.logonly. [ $+ [ $chan ] ] 1 | /chanmsg Quote+ log-only on. ( %QP.logonly. [ $+ [ $chan ] ] ) }
            elseif ( $4 == off ) { /unset %QP.write | /set %QP.logonly. [ $+ [ $chan ] ] 0 | /chanmsg Quote+ log-only off. ( %QP.logonly. [ $+ [ $chan ] ] ) }
            elseif ( $4 == status ) { /chanmsg Quote+ Log-only is currently $iif(%QP.logonly. [ $+ [ $chan ] ] == 1, enabled., disabled.) }
          }

          elseif ( $3 == log ) {
            if ( $4 != $null && $4 != status ) { /set %QP.log. [ $+ [ $chan ] ] $4 | /unset %QP.go | /unset %QP.write | /chanmsg I will now log $iif($4 == 1, every message, every $4 messages) $+ . }
            elseif ( $4 == status ) { /chanmsg Quote+ lograte is currently %QP.log. [ $+ [ $chan ] ] }
          }

          elseif ( $3 == respond ) {
            if ( $4 != $null && $4 != random && $4 != normal && $4 != status ) { /set %QP.respond.rate. [ $+ [ $chan ] ] $4 | /unset %QP.respond | /unset %QP.write. [ $+ [ $chan ] ] | /chanmsg I will now talk $iif($4 == 1, every message, every $4 messages) $+ . }
            if ( $4 == random || random isin $5- && normal !isin $5- ) { /chanmsg Quote+ response rate is now random. Note that I will choose a number between 1 and the previously set respond rate before responding. | /set %QP.random. [ $+ [ $chan ] ] 1 }
            if ( $4 == normal || normal isin $5- && random !isin $5- ) { /chanmsg Response rate is now a normal, set number. | /unset %QP.random. [ $+ [ $chan ] ] }
            elseif ( $4 == status ) { /chanmsg Quote+ response mode is currently $iif(%QP.random. [ $+ [ $chan ] ] == 1, random, normal) $+ , and the maximum response rate is %QP.respond.rate. [ $+ [ $chan ] ] }
          }

          if ( $3 == intelligence ) {
            if ( $4 == stupid || $4 == 1 ) {
              set %QP.intelligence. [ $+ [ $chan ] ] 1
              chanmsg My intelligence level is now "stupid" (1) (Usually ends up looking smarter, though!)
            }

            elseif ( $4 == normal || $4 == hybrid || $4 == 2 ) {
              set %QP.intelligence. [ $+ [ $chan ] ] 2
              chanmsg My inteeligence level is now "normal" (2)
            }


            elseif ( $4 == genius || $4 == 3) {
              set %QP.intelligence. [ $+ [ $chan ] ] 3
              chanmsg My intelligence level is now "genius" (3)
            }

            elseif ( $4- == super cyan || $4- == 666) {
              set %QP.intelligence. [ $+ [ $chan ] ] 666
              chanmsg 11,1I AM NOW SUPER CYAN.    
            }

            elseif ( $4 == status ) {
              chanmsg My intelligence level is currently %QP.intelligence. [ $+ [ $chan ] ]
            }
          }


          if ( $2 == forget ) {
            if ( $3 != $null && $3 != last && $3 != +action ) { necho Attempting to forget " $+ $3- $+ "... | /write -ds " [ $+ [ $3- ] $+ ] " "quoteplusdb.txt" | /chanmsg Forgot " $+ $3- $+ " | necho Forgot " $+ $3- $+ " | halt }
            elseif ( $3 == last ) { /write -ds " [ $+ [ %QP.last ] $+ ] " "quoteplusdb.txt" | /chanmsg Forgot " $+ %QP.last $+ " }
            elseif ( $3 == +action ) { necho Attempting to forget " $+ $4- $+ "... | /write -ds " [ $+ [ $4- ] $+ ] " "Settings\quoteplusactiondb.txt" | /chanmsg Forgot action " $+ $4- $+ " | necho Forgot action " $+ $4- $+ " | halt }
          }
          if ( $2 == forgetadv && $3 != $null && $3 != last ) { necho Attempting to forget " $+ $3- $+ "... | /write -dw " [ $+ [ $3- ] $+ ] " "quoteplusdb.txt" | /chanmsg Forgot " $+ $3- $+ " | necho Forgot " $+ $3- $+ " | halt }

          if ( $2 == learn && $3 != $null && $read(quoteplusdb.txt, w, $3-) == $null ) { /write "quoteplusdb.txt" $3- | /chanmsg Learned " $+ $3- $+ ". | halt }
          if ( $2 == learn && $3 != $null && $read(quoteplusdb.txt, w, $3-) != $null ) { /chanmsg I already know that! | halt }
        }
      }
      if ( $2 == Quote+ ) {
        if ( $3 == database ) { /chanmsg There are currently $lines(quoteplusdb.txt) lines in my Quote+ vocabulary. }
        elseif ( $3 == read && $4 != $null ) { /qpmsg $read(quoteplusdb.txt, $4) }
      }
      if ( $nick == blahblahbal && $ulevel == 3 ) {
        if ( $2 == global ) {
          if ( $3 == Quote+ ) {
            if ( $4 == on ) { /set %global.QP 1 | /chanmsg Global Quote+ on. }
            elseif ( $4 == off ) { /set %global.QP 0 | /chanmsg Global Quote+ off. }

            if ( $4 == log-only ) {
              if ( $5 == on ) { /set %global.QP.logonly 1 | /chanmsg Global Quote+ log-only on. }
              elseif ( $5 == off ) { /set %global.QP.logonly 0 | /chanmsg Global Quote+ log-only off. }
            }
            if ( $4 == log && $5 != $null ) { /set %global.QP.log $5 | /chanmsg Global maximum Quote+ log lines set to %global.QP.log $+ . } 
            if ( $4 == respond && $5 != $null ) { /set %global.QP.respond $5 | /chanmsg Global maximum Quote+ response rate set to %global.QP.respond $+ . }           
          }
        }
      }
    }
  }


  if ( $me == Jetty-Syn && %global.QP == 1 && %QP. [ $+ [ $chan ] ] == 1 ) {
    if ( $strip($1) == Jetty-Syn $+ , || $strip($1) == Jetty-Syn $+ : ) {
      if ( %qp.intelligence. [ $+ [ $chan ] ] != 666 ) {
        if ( $2 != $null && $2 != say && $2 != quote+ ) { /qpmsg $read(quoteplusdb.txt, w, * $+ [ $ [ $+ [ $rand(2,$0) ] ] ] $+ *, $rand(1,$lines(quoteplusdb.txt))) }
      }
      else {
        if ( $2 != $null && $2 != say && $2 != quote+ ) { var %qp. [ $+ [ $chan ] $+ ] .temp $rand(2,$0) | necho * [ $+ [ $ [ $+ [ %qp. [ $+ [ $chan ] $+ ] .temp ] $+ ] - [ $+ [ $rand(%qp. [ $+ [ $chan ] $+ ] .temp,$0) ] ] ] $+ ] * | qpmsg $nick $+ : $read(quoteplusdb.txt,w, * [ $+ [ $ [ $+ [ %qp. [ $+ [ $chan ] $+ ] .temp ] $+ ] - [ $+ [ $rand(%qp. [ $+ [ $chan ] $+ ] .temp,$0) ] ] ] $+ ] *,$rand(1,$lines(quoteplusdb.txt))) }
      }
    }
  }
  if ( $me == Jetty-Syn && %global.QP == 1 ) {
    if ( %QP. [ $+ [ $chan ] ] == 1 && %QP.logonly. [ $+ [ $chan ] ] != 1 ) {
      if ( %QP.intelligence. [ $+ [ $chan ] ] == 1 ) && ( %QP. [ $+ [ $chan ] $+ ] .randch != 100 ) { necho Looks like stupid mode is enabled! Setting this to 100. | /set %QP. [ $+ [ $chan ] $+ ] .randch 100 }
      if ( %QP.intelligence. [ $+ [ $chan ] ] == 2 ) { /set %QP. [ $+ [ $chan ] $+ ] .randch $rand(1,100) }
      if ( %QP.intelligence. [ $+ [ $chan ] ] == 3 ) && ( %QP. [ $+ [ $chan ] $+ ] .randch != 1 ) { necho Looks like genius mode is enabled! Setting this to 1. | /set %QP. [ $+ [ $chan ] $+ ] .randch 1 }
      if ( %QP.intelligence. [ $+ [ $chan ] ] == 666 ) && ( %QP. [ $+ [ $chan ] $+ ] .randch != 666 ) { necho Looks like I'm SUPER CYAN. | set %QP. [ $+ [ $chan ] $+ ] .randch 666 }

      if ( Jetty-Syn !isin $1 ) { /inc %QP.write. [ $+ [ $chan ] ] | /inc %QP.respond. [ $+ [ $chan ] ] }

      if ( %QP.write. [ $+ [ $chan ] ] >= %QP.log. [ $+ [ $chan ] ] && Jetty-Syn !isin $1 && http: !isin $1- && https: !isin $1- && ~ !isin $1 ) {
        /qplearn $chan $1-
      }

      if ( %QP.respond. [ $+ [ $chan ] ] >= %QP.respond.rate. [ $+ [ $chan ] ] && ! !isin $1 ) {

        if ( %QP.intelligence. [ $+ [ $chan ] ] != 2 ) { necho Intelligence level is not 2 (normal), acting accordingly. }

        if ( %QP.random. [ $+ [ $chan ] ] != 1 ) {
          if ( $1 != $null && %QP. [ $+ [ $chan ] $+ ] .randch < 50 ) { /qpmsg $read(quoteplusdb.txt, w, * $+ [ $ [ $+ [ $rand(1,$0) ] ] ] $+ *, $rand(1,$lines(quoteplusdb.txt))) | /set %QP.respond. [ $+ [ $chan ] ] 0 | halt }
          elseif ( $1 != $null && %QP. [ $+ [ $chan ] $+ ] .randch >= 50 && %QP. [ $+ [ $chan ] $+ ] .randch < 666 ) { /qpmsg $read(quoteplusdb.txt) | /set %QP.respond. [ $+ [ $chan ] ] 0 | halt }
          elseif ( $1 != $null && %QP. [ $+ [ $chan ] $+ ] .randch == 666 ) { var %qp. [ $+ [ $chan ] $+ ] .temp $rand(1,$0) | necho * [ $+ [ $ [ $+ [ %qp. [ $+ [ $chan ] $+ ] .temp ] $+ ] - [ $+ [ $rand(%qp. [ $+ [ $chan ] $+ ] .temp,$0) ] ] ] $+ ] * | qpmsg $read(quoteplusdb.txt,w, * [ $+ [ $ [ $+ [ %qp. [ $+ [ $chan ] $+ ] .temp ] $+ ] - [ $+ [ $rand(%qp. [ $+ [ $chan ] $+ ] .temp,$0) ] ] ] $+ ] *,$rand(1,$lines(quoteplusdb.txt))) | /set %QP.respond. [ $+ [ $chan ] ] 0 | halt }

        }


        if ( %QP.random. [ $+ [ $chan ] ] == 1 ) {
          if ( $1 != $null && %QP. [ $+ [ $chan ] $+ ] .randch < 50) { /qpmsg $read(quoteplusdb.txt, w, * $+ [ $ [ $+ [ $rand(1,$0) ] ] ] $+ *, $rand(1,$lines(quoteplusdb.txt))) | /set %QP.respond. [ $+ [ $chan ] ] $rand(0, %QP.respond.rate. [ $+ [ $chan ] ] ) | halt }
          elseif ( $1 != $null && %QP. [ $+ [ $chan ] $+ ] .randch >= 50 && %QP. [ $+ [ $chan ] $+ ] .randch < 666 ) { /qpmsg $read(quoteplusdb.txt) | /set %QP.respond. [ $+ [ $chan ] ] $rand(0, %QP.respond.rate. [ $+ [ $chan ] ] ) | halt }
          elseif ( $1 != $null && %QP. [ $+ [ $chan ] $+ ] .randch == 666 ) { var %qp. [ $+ [ $chan ] $+ ] .temp $rand(1,$0) | necho * [ $+ [ $ [ $+ [ %qp. [ $+ [ $chan ] $+ ] .temp ] $+ ] - [ $+ [ $rand(%qp. [ $+ [ $chan ] $+ ] .temp,$0) ] ] ] $+ ] * | qpmsg $read(quoteplusdb.txt,w, * [ $+ [ $ [ $+ [ %qp. [ $+ [ $chan ] $+ ] .temp ] $+ ] - [ $+ [ $rand(%qp. [ $+ [ $chan ] $+ ] .temp,$0) ] ] ] $+ ] *,$rand(1,$lines(quoteplusdb.txt))) | /set %QP.respond. [ $+ [ $chan ] ] $rand(0, %QP.respond.rate. [ $+ [ $chan ] ] ) | halt }
        }
      }
    }

    if ( %QP. [ $+ [ $chan ] ] != 1 && %QP.logonly. [ $+ [ $chan ] ] == 1 && %global.QP.logonly == 1 ) {
      if ( Jetty-Syn !isin $1 ) { /inc %QP.write. [ $+ [ $chan ] ] }

      if ( %QP.write. [ $+ [ $chan ] ] >= %QP.log. [ $+ [ $chan ] ] && http: !isin $1- && https: !isin $1- && ~ !isin $1 ) { /qplearn $chan $1- }
    }
  }
}

fon *:ACTION:*:#:{
  if ( $me == Jetty-Syn && %global.QP == 1 ) {
    if ( %QP. [ $+ [ $chan ] ] == 1 && %QP.logonly. [ $+ [ $chan ] ] != 1 ) {
      inc %QP.write. [ $+ [ $chan ] ] | /inc %QP.respond. [ $+ [ $chan ] ]
      if ( %QP.respond. [ $+ [ $chan ] ] >= %QP.respond.rate. [ $+ [ $chan ] ] ) {
        /qpdesc $read(Settings\quoteplusactiondb.txt)
        if ( %QP.random. [ $+ [ $chan ] ] != 1 ) { /set %QP.respond. [ $+ [ $chan ] ] 0 }
        elseif ( %QP.random. [ $+ [ $chan ] ] == 1 ) { /set %QP.respond. [ $+ [ $chan ] ] $rand(0, %QP.respond.rate. [ $+ [ $chan ] ] ) }
      }

      if ( $me isin $1- ) { /qpdesc $read(Settings\quoteplusactiondb.txt) }

      if ( %QP.write. [ $+ [ $chan ] ] >= %QP.log. [ $+ [ $chan ] ] && http: !isin $1- && https: !isin $1- ) {
        /qplearnact $chan $1-
      }
    }
    if ( %QP. [ $+ [ $chan ] ] != 1 && %QP.logonly. [ $+ [ $chan ] ] == 1 ) {
      inc %QP.write. [ $+ [ $chan ] ] | /inc %QP.respond. [ $+ [ $chan ] ]
      if ( %QP.write. [ $+ [ $chan ] ] >= %QP.log. [ $+ [ $chan ] ] && http: !isin $1- && https: !isin $1- && ~ !isin $1 ) {
        /qplearnact $chan $1-
      }
    }
  }
}

alias /qplearn {
  if ( $ulevel != 0 ) {
    set %QP.last $2-
    var %QPtemp [ $+ [ $chan ] ] $2-
    var %QPtemp2 [ $+ [ $chan ] ] 1
    var %QPtemp3 [ $+ [ $chan ] ] 1
    while ( %QPtemp2 [ $+ [ $chan ] ] <= $0 ) {
      while ( %QPtemp3 [ $+ [ $chan ] ] <= $nick($1,0) ) {
        if ( $nick($1, %QPtemp3 [ $+ [ $chan ] ] ) isin %QPtemp [ $+ [ $chan ] ] && $nick($1, %QPtemp3 [ $+ [ $chan ] ] ) != g ) { set %QPtemp [ $+ [ $chan ] ] $replace(%QPtemp [ $+ [ $chan ] ], $chan, [channel], $nick($1, %QPtemp3 [ $+ [ $chan ] ]), [name]) }
        inc %QPtemp3 [ $+ [ $chan ] ]
      }
      inc %QPtemp2 [ $+ [ $chan ] ]
    }
    set %QP.last %QPtemp [ $+ [ $chan ] ]
    if ( $read(quoteplusdb.txt, w, %QPtemp [ $+ [ $chan ] ]) == $null ) { 
      write "quoteplusdb.txt" %QPtemp [ $+ [ $chan ] ]
      necho Learned " $+ %QP.last $+ " from $nick on $chan $+ , $network $+ .
      set %QP.write. [ $+ [ $chan ] ] 0
    }
    unset %QPtemp [ $+ [ $chan ] ]
  }
}

alias /qplearnact {
  if ( $ulevel != 0 ) {
    set %QP.last $2-
    var %QPtempact [ $+ [ $chan ] ] $2-
    var %QPtempact2 [ $+ [ $chan ] ] 1
    var %QPtempact3 [ $+ [ $chan ] ] 1
    while ( %QPtempact2 [ $+ [ $chan ] ] <= $0 ) {
      while ( %QPtempact3 [ $+ [ $chan ] ] <= $nick($1,0) ) {
        if ( $nick($1, %QPtempact3 [ $+ [ $chan ] ]) isin %QPtempact [ $+ [ $chan ] ] ) { set %QPtempact [ $+ [ $chan ] ] $replace(%QPtempact [ $+ [ $chan ] ], $chan, [channel], $nick($1, %QPtempact3 [ $+ [ $chan ] ]), [name]) }
        inc %QPtempact3 [ $+ [ $chan ] ]
      }
      inc %QPtempact2 [ $+ [ $chan ] ]
    }
    set %QP.last %QPtempact [ $+ [ $chan ] ]
    if ( $read($mircdir\Settings\quoteplusactiondb.txt, w, %QPtempact [ $+ [ $chan ] ]) == $null ) { 
      write "Settings\quoteplusactiondb.txt" %QPtempact [ $+ [ $chan ] ]
      necho Learned action " $+ %QP.last $+ " from $nick on $chan $+ , $network $+ .
      set %QP.write. [ $+ [ $chan ] ] 0
    }
    unset %QPtempact [ $+ [ $chan ] ]
  }
}

alias /qpmsg {
  var %qp.rr. [ $+ [ $chan ] ] $0
  var %qp.rr.l. [ $+ [ $chan ] ] 1
  while ( %qp.rr.l. [ $+ [ $chan ] ] <= %qp.rr. [ $+ [ $chan ] ] ) {
    set %qp.rr.rep. [ $+ [ $chan ] ] $replace([ $ [ $+ [ %qp.rr.l. [ $+ [ $chan ] ] ] ] ],[name],$nick($chan,$rand(1,$nick($chan,0))),[channel],$chan)
    set %qp.rr.out. [ $+ [ $chan ] ] %qp.rr.out. [ $+ [ $chan ] ] %qp.rr.rep. [ $+ [ $chan ] ]
    inc %qp.rr.l. [ $+ [ $chan ] ]
  }
  msg $chan %qp.rr.out. [ $+ [ $chan ] ]
  unset %qp.rr.*. [ $+ [ $chan ] ]
}

alias /qpdesc {
  var %qp.rr. [ $+ [ $chan ] ] $0
  var %qp.rr.l. [ $+ [ $chan ] ] 1
  while ( %qp.rr.l. [ $+ [ $chan ] ] <= %qp.rr. [ $+ [ $chan ] ] ) {
    set %qp.rr.rep. [ $+ [ $chan ] ] $replace([ $ [ $+ [ %qp.rr.l. [ $+ [ $chan ] ] ] ] ],[name],$nick($chan,$rand(1,$nick($chan,0))),[channel],$chan)
    set %qp.rr.out. [ $+ [ $chan ] ] %qp.rr.out. [ $+ [ $chan ] ] %qp.rr.rep. [ $+ [ $chan ] ]
    inc %qp.rr.l. [ $+ [ $chan ] ]
  }
  describe $chan %qp.rr.out. [ $+ [ $chan ] ]
  unset %qp.rr.*. [ $+ [ $chan ] ]
}
