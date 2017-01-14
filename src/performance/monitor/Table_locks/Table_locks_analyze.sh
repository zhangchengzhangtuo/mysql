#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load QPS";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Table_locks_immediate/ {
	Table_locks_immediate=$2;
 	printf " %s",Table_locks_immediate;
    }
    /Table_locks_waited/{
	Table_locks_waited=$2;
	printf " %s",Table_locks_waited;
	printf fmt,Table_locks_waited/Table_locks_immediate;
    }
    ' "$@"

