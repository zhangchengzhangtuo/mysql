#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load open_tables opened_tables";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Open_tables/ {
	printf " %s",$2;
    }
    /Opened_tables/{
	printf " %s",$2;
    }
    ' "$@"

