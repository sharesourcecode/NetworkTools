#!/bin/bash
termux-wake-lock &> /dev/null
if [[ $? = 0 ]]; then
	termux-setup-storage
	STORAGE=$HOME/storage/downloads/speedtestmonitor/
else
	STORAGE=$HOME/speedtestmonitor/
fi
mkdir -p $STORAGE
cd $STORAGE
FILE="tests_$(date +%d_%m_%Y).txt"
echo -e "Result will be saved in:\n`pwd`\n$FILE\n"
if [[ -e $FILE && -n $FILE ]]; then
	read -p "File not empty. Overwrite? [y/n] " -e -n 1 OP
	case $OP in
		(y|Y) clear; >$FILE; echo 'Starting...' ;;
		(n|N) clear; echo 'Starting...' ;;
		(*) echo -e "nInvalid optionn"; exit 0 ;;
	esac
else
	touch $FILE
fi
while true; do
	echo -e "\n" >>$FILE
	echo 'https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -' >>$FILE
	curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - >>$FILE
	date +%H:%M:%S_%d/%m/%Y >>$FILE
	echo -e "\n" >>$FILE
	cat $FILE | grep ':' | tail -n4
	sleep 30m
done
exit
