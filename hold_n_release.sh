#!/bin/bash

# hold_n_release.sh Executes one of various programs according to the delay
# from the button press until the consecuent release 

# Based on doubleclick_delayed from   https://www.nongnu.org/xbindkeys/xbindkeys.html
# Modified By Luis Tapia <https://github.com/lmtapia>

BASE="`dirname "$(readlink -f "$0")"`"
BUTTON=$1
PROGS=$BASE/hold_n_release.$BUTTON.commands
LOCK=$BASE/tmp/hold_n_release.$BUTTON.lock
LINES=$(wc -l < $PROGS)

if [ -z "$BUTTON" -o ! -f $PROGS ]; then
  echo "Usage, for button pressed: hold_n_release <Button>"
  echo "for release:               hold_n_release <Button> release [delay=1]"
  echo "Put the commands on a file $BASE/hold_n_release.<Button>.commands one per line"
  exit
fi
EPOCH=$(date +'%s')

if [[ "$2" == "release" &&  -e $LOCK ]] ; then
  if [[ -z "$3" ]]; then DELAY=1; else DELAY=$3; fi
  LASTTIME=`cat $LOCK`
  CHOICE=$(( (EPOCH - LASTTIME) / DELAY + 1 )) 
  # echo $CHOICE
  if [ $CHOICE -le $LINES ]; then
    exec $(sed  -n "$CHOICE{p;q}" $PROGS) &
  fi
else 
  rm -f $LOCK
  echo  "$EPOCH" > $LOCK; 
fi

