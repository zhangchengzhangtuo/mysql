#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load Created_tmp_disk_tables Created_tmp_tables";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Created_tmp_disk_tables/ {
	Created_tmp_disk_tables=$2;
	printf " %s",Created_tmp_disk_tables;
    }
    /Created_tmp_tables/{
	Created_tmp_tables=$2;
	printf " %s",Created_tmp_tables;
	printf fmt,Created_tmp_disk_tables/Created_tmp_tables;
    }
    ' "$@"

