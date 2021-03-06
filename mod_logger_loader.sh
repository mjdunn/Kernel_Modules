#!/bin/bash
# script to ins and remove PUF kernel Module and logging into file.
DELAY=60
BASEENAME="_PUF.log"
DUMPFILE="Mem_dump_file.log"
for TIME in {1..2}
do
DELAY=$((TIME*60))
FILENAME=$DELAY$BASEENAME
dmesg -c >> ${FILENAME};
 for TEST in {1..50}
 do
   echo "PUF Module LOADED:TEST:$TEST with decay DELAY:$DELAY";
   insmod pandamod.ko puf_base_addr=0xa0000000 puf2_base_addr=0xb0000000 puf_init_val=0x0 puf_delaySec=$DELAY;
   dmesg -c >> ${DUMPFILE};
   sleep $DELAY;
   sleep 60;
   dmesg -c >> ${FILENAME};
   rmmod kernel_panda.ko;
   sleep 30;
   echo "PUF Module REMOVED:TEST:$TEST";
  done
done
