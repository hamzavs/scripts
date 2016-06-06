#!/bin/bash

#
# I use this script to do a recursive grep on a source code repository
# in order to get the files contaiing a specefic string which are generally
# java classess, then get the first commentary block which my contain the
# use of that class
#

# $string_to_exclude : some binary files which can't be opened are to be excluded from the result

grep -inr $1 |grep -v $string_to_exclude | cut -d ' ' -f 1|cut -d ':' -f '1' 1> tmp.log 2>/dev/null

# creating a log file or emptying if it does exist
echo >$1.log

# keep one instance of file name and eliminate redendance
sort -u tmp.log >tmp2

cat tmp2 > tmp.log && rm -f tmp2
cat tmp.log | while read line
do

#send ouput result to the log file and have a copy stored somewhere else
echo -e "\n\n=================\n  $line \n\n" >>$1.log
cat $line | sed  '/\/\*/,/\*\//!d;/\*\//q' >>$1.log

done

cp $1.log /home/centos/Desktop/logs/
chmod 777 /home/centos/Desktop/logs/*
