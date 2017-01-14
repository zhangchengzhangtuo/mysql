#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load Handler_read_key_PS Handler_read_rnd_next_PS";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Handler_read_key/ {
	printf fmt,($2-Handler_read_key)/diff;
	Handler_read_key=$2;
    }
    /Handler_read_rnd_next/{
	printf fmt,($2-Handler_read_rnd_next)/diff;
	Handler_read_rnd_next=$2;
    }
    ' "$@"

