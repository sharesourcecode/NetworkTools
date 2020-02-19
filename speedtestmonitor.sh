#!/bin/bash
termux-wake-lock &> /dev/null
if [[ $? = 0 ]]; then
	termux-setup-storage
	STORAGE=$HOME/storage/downloads/
	echo -e "Result will be saved in /storage/emulated/0/Downloads/tests.txt\n"
else
	STORAGE=$HOME
	echo -e "Result will be saved in $HOME/tests.txt\n"
fi
cd $STORAGE
FILE=tests.txt
if [[ -n $FILE ]]; then
	read -p "File not empty. Overwrite? [y/n] " -e -n 1 OP
	case $OP in
		(y|Y)
		clear; >tests.txt; echo 'Starting...' ;;
		(n|N) clear; echo 'Starting...' ;;
		(*) echo -e "nInvalid optionn"; exit 0 ;;
	esac
fi
while true; do
echo -e "\n" >> tests.txt
echo 'https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -' >>tests.txt
curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - >>tests.txt
date +%H:%M:%S_%d/%m/%Y >> tests.txt
echo -e "\n" >> tests.txt
cat tests.txt | tail -n9
sleep 30m
done
exit
