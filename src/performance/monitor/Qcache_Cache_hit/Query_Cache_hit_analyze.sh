#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load Qcache_hits Qcache_insert Query_Qcache_hit";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Qcache_hits/{
	Qcache_hits=$2;
	printf " %s",Qcache_hits;
    }
    /Qcache_inserts/{
	Qcache_inserts=$2;
	printf " %s",Qcache_hits;
	#printf fmt,Qcache_hits/(Qcache_hits+Qcache_inserts);
    }
    ' "$@"

