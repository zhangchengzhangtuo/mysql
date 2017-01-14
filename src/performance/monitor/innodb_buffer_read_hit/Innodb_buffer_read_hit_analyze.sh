#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load Innodb_buffer_pool_read_requests Innodb_buffer_pool_reads Innodb_buffer_read_hit";
	fmt=" %.2f";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	diff=ts-prev_ts;
	prev_ts=ts;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Innodb_buffer_pool_read_requests/{
        Innodb_buffer_pool_read_requests=$2;
        printf " %s",Innodb_buffer_pool_read_requests;
    }
    /Innodb_buffer_pool_reads/ {
	Innodb_buffer_pool_reads=$2;	
	printf " %s",Innodb_buffer_pool_reads;
        Innodb_buffer_read_hit=1-Innodb_buffer_pool_reads/Innodb_buffer_pool_read_requests;
        printf fmt,Innodb_buffer_read_hit;
    }
    ' "$@"

