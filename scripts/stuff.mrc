
on *:text:~text*:#:{
  if ($2 == $null) { notice $nick Missing 1 parameter: | notice $nick Reverse, Backwards, Binary, Hexify, Leet, Morse, Rainbow } 
  if ($2 == morse && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $replace($3-,a,$+(.-,$chr(32)),b,$+(-...,$chr(32)),c,$+(-.-.,$chr(32)),d,$+(-..,$chr(32)),e,$+(.,$chr(32)),f,$+(..-.,$chr(32)),g,$+(--.,$chr(32)),h,$+(....,$chr(32)),i,$+(..,$chr(32)),j,$+(.---,$chr(32)),k,$+(-.-,$chr(32)),l,$+(.-..,$chr(32)),m,$+(--,$chr(32)),n,$+(-.,$chr(32)),o,$+(---,$chr(32)),p,$+(.--.,$chr(32)),q,$+(--.-,$chr(32)),r,$+(.-.,$chr(32)),s,$+(...,$chr(32)),t,$+(-,$chr(32)),u,$+(..-,$chr(32)),v,$+(...-,$chr(32)),x,$+(-..-,$chr(32)),z,$+(--..,$chr(32)),y,$+(-.--,$chr(32)),w,$+(.--,$chr(32))) }
  if ($2 == leet && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $replace($3-,t,7,a,4,e,3,s,z,i,1,o,0,H,|-|,K,|<,A,@,M,|\/|,N,|\|) }
  if ($2 == hexify && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $hex($3-).encode }
  if ($2 == rainbow && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $rainbow( $+ $3- $+ ) %chars }
  if ($2 == rainbow2 && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $rainbow2( $+ $3- $+ ) }
  if ($2 == Binary && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $binary( $+ $3- $+ ) }
  if ($2 == UnBinary && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $binary( $+ $3- $+ ,b $+ ) }
  if ($2 == reverse && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $reverset( $+ $3- $+ ) }
  if ($2 == backwards && %com.enabled. [ $+ [ $chan ] ] == 1) { 
  msg $chan $54 $53 $52 $51 $50 $49 $48 $47 $46 $45 $44 $43 $42 $41 $40 $39 $38 $37 $36 $35 $34 $33 $32 $31 $30 $29 $28 $27 $26 $25 $24 $23 $22 $21 $20 $19 $18 $17 $16 $15 $14 $13 $12 $11 $10 $9 $8 $7 $6 $5 $4 $3 }
}
#Alias# (Put this in alias)

alias binary {
  if ($isid) {
    if ($regex($1,/[^01]/)) {
      if ($len($1) < 117) {
        if (!$2) {
          var %str = $1,%x = 1,%y
          while (%x <= $len(%str)) {
            %y = $+(%y,$base($asc($mid(%str,%x,1)),10,2,8))
            inc %x
          }
          return %y
        }
        else echo $color(info) -a $!binary Invalid Parameter: $&
          Text-to-Binary Conversion does not take a second parameter. | halt
      }
      else echo $color(info) -a $!binary Invalid Parameter: $&
        String too long. Must be shorter than 117 characters.
    }
    else {
      if ($2) {
        if ($2 === b) {
          if (!$regex($calc($len($1) / 8),/^\d+\.\d+$/)) {
            var %str = $1,%x = 1,%y
            while (%x <= $len(%str)) {
              %y = $+(%y,$chr($iif($base($mid(%str,%x,8),2,10) == 32,160,$v1))))
              inc %x 8
            }
            return %y
          }
          else echo $color(info) -a $!binary Invalid Parameter: $&
            Malformed Binary. Must be divisible by 8. | halt
        }
        else echo $color(info) -a $!binary Invalid Parameter: $&
          Binary-to-Text Conversion requires the "b" parameter. $&
          $!binary(01010101, $+ $+($chr(3),04,b,$chr(3)) $+ ) | halt
      }
      else echo $color(info) -a $!binary Invalid Parameter: $&
        Binary-to-Text Conversion requires the "b" parameter. $&
        $!binary(01010101, $+ $+($chr(3),04,b,$chr(3)) $+ ) | halt
    }
  }
  else echo $color(info) -a $!binary Invalid Usage: /binary - $!binary(T/B[,b]) | halt
}
##########################################################################################################################################
alias hex {
  if ($1) {
    if ($prop == encode) {
      return $replacecs($1-,$chr(44),2C,$chr(40),28,$chr(41),29,$chr(36),24,$chr(37),25,$chr(125),7D,$chr(123),7B,$chr(32),20,!,21,",22,#,23,&,26,',27,*,2A,+,2B,-,2D,.,2E,/,2F,0,30,1,31,2,32,3,33,4,34,5,35,6,36,7,37,8,38,9,39,:,3A,;,3B,<,3C,=,3D,>,3E,?,3F,`,60,a,61,b,62,c,63,d,64,e,65,f,66,g,67,h,68,i,69,j,6A,k,6B,l,6C,m,6D,n,6E,o,6F,p,70,q,71,r,72,s,73,t,74,u,75,v,76,w,77,x,78,y,79,z,7A,$chr(124),7C,~,7E) $+ 00
    }
    if ($prop == decode) {
      var %dec = $calc($len($1-) / 2)
      var %dec. = $len($1-)
      var %num = 2
      while (%num =< %dec) {
        set %txt $left($1-,%num) $+ $chr(1) $+ $right($1-,$calc(%dec. - %num))
        inc %num 2
      }
      %num = 1
      while (%num <= $numtok(%txt,1)) {
        set %txt $replace($gettok(%txt,%num,32),2C,$chr(44),28,$chr(40),29,$chr(41),24,$chr(36),25,$chr(37),7D$chr(125),7B,$chr(123),20,$chr(32),21,!,22,",23,#,26,&,27,',2A,*,2B,+,2D,-,2E,.,2F,/,30,0,31,1,32,2,33,3,34,4,35,5,36,6,37,7,38,8,39,9,3A,:,3B,;,3C,<,3D,=,3E,>,3F,?,60,`,61,a,62,b,63,c,64,d,65e,66,f,67,g,68,h,69,i,6A,j,6B,k,6C,l,6D,m,6E,n,6F,o,70,p,71,q,72,r,73,s,74,t,75,u,76,v,77,w,78,x,79,y,7A,z,7C,$chr(124),7E,~)
        inc %num 1
      }
      set %txt $remove(%txt, $chr(1))
      return %txt
      unset %txt
    }
  }
  on *:load: {
    set %alfa a b c d e f g h i j k l m n o p q r s t u v w x y z
    set %morse .- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..
  }
  on *:unload: {
    unset %alfa 
    unset %morse 
  }
  #morse off
  on *:input:*: {
    if (/* !iswm $1-) {
      say $replace($1-,a,$+(.-,$chr(32)),b,$+(-...,$chr(32)),c,$+(-.-.,$chr(32)),d,$+(-..,$chr(32)),e,$+(.,$chr(32)),f,$+(..-.,$chr(32)),g,$+(--.,$chr(32)),h,$+(....,$chr(32)),i,$+(..,$chr(32)),j,$+(.---,$chr(32)),k,$+(-.-,$chr(32)),l,$+(.-..,$chr(32)),m,$+(--,$chr(32)),n,$+(-.,$chr(32)),o,$+(---,$chr(32)),p,$+(.--.,$chr(32)),q,$+(--.-,$chr(32)),r,$+(.-.,$chr(32)),s,$+(...,$chr(32)),t,$+(-,$chr(32)),u,$+(..-,$chr(32)),v,$+(...-,$chr(32)),x,$+(-..-,$chr(32)),z,$+(--..,$chr(32)),y,$+(-.--,$chr(32)),w,$+(.--,$chr(32)))
      halt
    }
  }
}
#morse end
alias morse {
  var %t = 1, %y = $numtok($1-,32)
  while (%t <= %y) {
    set %translate $instok(%translate,$reptok($ [ $+ [ %t ] ],$gettok(%morse,$findtok(%morse,$ [ $+ [ %t ] ],32),32),$gettok(%alfa,$findtok(%morse,$ [ $+ [ %t ] ],32),32),32),%t,32)
    inc %t
  }
  echo -ta %translate
  unset %translate
}
##########################################################################################################################################

alias rainbow { var %colors = 4 7 8 3 2 6 | $iif($isid,return,msg $active) $regsubex($1-,/([^ ])/g,$+($chr(3),$base($gettok(%colors,$calc((\n -1) % $numtok(%colors,32) + 1),32),10,10,2),\t)) }
alias rainbow2 { return $regsubex($1-,/(.)/g,$+($chr(3),$iif($r(1,15) < 10,$+(0,$v1),$v1),\1)) }

#Some of the aliases i didn't make. so the credits go to the authors#
