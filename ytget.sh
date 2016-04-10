#!/bin/bash

set -o errexit
set -o nounset

YTGET_USER=
YTGET_PASS=
YTGET_DIR=~/ytget

source $YTGET_DIR/ytget.conf

if [ -n "$YTGET_USER" ] ; then
  YTGET_USER="-u $YTGET_USER"
fi

if [ -n "$YTGET_PASS" ] ; then
  YTGET_PASS="-p $YTGET_PASS"
fi

function downloadQueue() {
  youtube-dl --cookies $YTGET_DIR/youtube-dl-cookies.txt --mark-watched $YTGET_USER $YTGET_PASS --no-playlist -a queue.txt
}

function rotateQueues() {
  for i in $(seq 4 -1 1) ; do
    if [ -e $YTGET_DIR/prev_queue$i.txt ] ; then
      mv $YTGET_DIR/prev_queue$i.txt $YTGET_DIR/prev_queue$(($i+1)).txt
    fi
  done
  mv queue.txt $YTGET_DIR/prev_queue1.txt
  touch queue.txt
}

if [ ! -e queue.txt ] ; then
  echo "Can't find queue.txt"
elif [ ! -s queue.txt ] ; then
  echo "Queue empty: queue.txt"
fi

while [ -s queue.txt ] ; do
  downloadQueue
  rotateQueues
  if [ -e nextqueue.txt ] ; then
    echo -e "***\n*** Moving nextqueue.txt ==> queue.txt\n***"
    mv nextqueue.txt queue.txt
  fi
done
