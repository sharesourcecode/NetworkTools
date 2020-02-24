#!/bin/bash
echo 'Long tests will be done, be patient.'
num=1493
until [[ -n $RCVD && $RCVD -eq 10 || $num -lt 576 ]]; do
	num=$[$num-1]
	echo -e "Checking $num bytes..."
	PING=$(ping -s $num -c10 google.com)
	RCVD=$(echo $PING | grep -o '10 received' | tr -cd "[[:digit:]]")
	clear
done
if [[ $RCVD -eq 10 ]]; then
	echo -e "\n MTU: $(echo $PING | grep 'PING' | cut -d\) -f2 | cut -d\( -f2)"
else
	echo -e "\nA connection error has occurred, MTU cannot be found. Please check your network and try again."
fi
exit
