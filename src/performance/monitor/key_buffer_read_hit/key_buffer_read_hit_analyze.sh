#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load key_read_requests key_reads key_buffer_read_hit";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Key_read_requests/{
	key_read_requests=$2;
	printf " %s",key_read_requests;
    }
    /Key_reads/ {
        key_reads=$2;   
        printf " %s",key_reads;
        #key_buffer_read_hit=1-key_reads/key_read_requests
        #printf fmt,key_buffer_read_hit;
    }

    ' "$@"

