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
    /Com_commit/ {
	commit=$2-Comcommit;	
	Comcommit=$2;
    }
    /Com_rollback/{
	rollback=$2-Comrollback;
	Comrollback=$2;
	sum=commit+rollback;
	printf fmt,sum/diff;
    }
    ' "$@"

