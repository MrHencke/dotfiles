#!/bin/bash

	log=$HOME/.xlog
	path=${1#file://}

        if [ -d $path ]
	then
        	/usr/bin/st -e "/usr/bin/$FILE $path" &>> $log
	else
		/usr/bin/st -e "/usr/bin/$FILE --selectfile=$path" &>> $log
	fi
