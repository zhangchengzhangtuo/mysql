#!/bin/sh
awk '
    BEGIN {
	printf "#ts date time load QPS";
    }
    /^TS/ {
	ts=substr($2,1,index($2,".")-1);
	load=NF-2;
	printf "\n%s %s %s %s",ts,$3,$4,substr($load,1,length($load)-1);
    }
    /Aborted_clients/ {
	printf " %s",$2;
    }
    /Aborted_connects/{
	printf " %s",$2;
    }
    /Connections/{
	printf " %s",$2;
    }
    /Max_used_connections/{
	printf " %s",$2;
    }
    /Threads_connected/{
	printf " %s",$2;
    }
    ' "$@"

