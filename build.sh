#!/bin/bash

. config/get_tz.sh
docker build -t 42_devctr .
rm tz_tmp

mkdir -p ~/bin
cp checkme.sh ~/bin/checkme
if [[ $(cat ~/.bashrc | grep -c :$HOME/bin) -eq 0 ]]; then
	echo "Append path..."
	echo "export PATH=$PATH:$HOME/bin" >> ~/.bashrc
	. ~/.bashrc
fi

echo 'Docker build done!'
