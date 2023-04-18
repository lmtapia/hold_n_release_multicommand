#!/bin/bash
#
# hold_n_release.sh Executes one of various programs according to the delay
# from the button press until the release 

# Based on doubleclick_delayed from   https://www.nongnu.org/xbindkeys/xbindkeys.html
# Modified By Luis Tapia <https://github.com/TapiaX>

BASE="`dirname "$(readlink -f "$0")"`"
BUTTON=$1
DELAY=$2
PROGS=$BASE/hold_n_release.$BUTTON.commands
LOCK=$BASE/tmp/hold_n_release.$BUTTON.lock
LINES=$(wc -l < $PROGS)
if [ -z "$BUTTON" -o -z "$DELAY" -o ! -f $PROGS ]; then
  echo "Usage : hold_n_release <Button> <Delay (sec)> [release]"
  echo "put the commands on a file named $BASE/hold_n_release.<Button>.commands one per line" 
  exit
fi
EPOCH=$(date +'%s')

if [[ "$3" == "release" &&  -e $LOCK ]] ; then
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

