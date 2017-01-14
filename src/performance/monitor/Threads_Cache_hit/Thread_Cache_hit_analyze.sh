#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load Connections Threads_created TCH";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Connections/ {
	printf " %s",$2;
	Connections=$2;
    }
    /Threads_created/{
	Threads_created=$2;
	printf " %s",$2;
	printf fmt,1-Threads_created/Connections;
    }
    ' "$@"

