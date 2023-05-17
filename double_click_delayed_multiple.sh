#!/bin/sh
#
# doubleclick_delayed_multiple.sh Executes various programs according to the delay
# until the release event 

# Based on doubleclick_delayed from   https://www.nongnu.org/xbindkeys/xbindkeys.html
# Modified By Luis Tapia <https://github.com/lmtapia>

BUTTON=$1
DELAY=$2
PROGS=hold_n_release.$BUTTON.commands
LOCK=./tmp/hold_n_release.$BUTTON.lock
LINES=$(wc -l < $PROGS)
if [ -z "$BUTTON" -o -z "$DELAY" -o ! -f $PROGS ]; then
  echo "Usage : doubleclick_delayed_multiple <Button> <Delay (sec)>" 
  echo "put the commands in the file hold_n_release.<Button>.commands for each button " 
  exit
fi
EPOCH=`date +'%s'`
if [ -e $LOCK ]; then
  LASTTIME=`cat $LOCK`
  CHOICE=$(( (EPOCH - LASTTIME) / DELAY + 1 )) 
  echo $CHOICE
  if [ $CHOICE -le $LINES ]; then
    echo $(sed  -n "$CHOICE{p;q}" $PROGS)
    rm -f $LOCK
  else
    echo "$EPOCH" > $LOCK;
  fi
else 
  echo  "$EPOCH" > $LOCK; 
fi

