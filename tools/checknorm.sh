#!/bin/bash

VERSION='0.3.0'

# Define colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

OK=0
KO=0
SHOW_SRC=false
MAKE_BUILD=false

help_menu ()
{
    echo "Usage: ./check_norm.sh [OPTION]"
    echo "Norminette checker, counts number of OK & KO."
    echo ""
    echo "OPTIONS"
    echo -e "  -h\t\tShow the help menu."
    echo -e "  -s\t\tPrint the source code of each file checked."
    echo -e "  -m\t\tRun makefile (Experimental)."
}

print_header ()
{
echo -e "
${BLUE}
   _  ______  ___  __  ___  _______           __  
  / |/ / __ \/ _ \/  |/  / / ___/ /  ___ ____/ /__
 /    / /_/ / , _/ /|_/ / / /__/ _ \/ -_) __/  '_/
/_/|_/\____/_/|_/_/  /_/  \___/_//_/\__/\__/_/\_\ 
                                                   
Version ${VERSION}${NC}
"
}

print_header

# Get options
while getopts "hsm" flag; do
 case $flag in
   h) # Handle the -h flag
   help_menu
   exit 0
   ;;
   s)
   SHOW_SRC=true
   ;;
   m)
   MAKE_BUILD=true
   ;;
   \?)
   # Handle invalid options
   echo "Invalid option, ignoring..."
   exit 0
   ;;
 esac
done

file_found=$(find . -iname "*.c" -o -iname "*.h")

echo -e "Files: $(echo "$file_found" | wc -l)\n\n>> Run Check..." 

for i in $(echo "$file_found" | sort)
do
  file_type=${i: -1}
  if [ "$SHOW_SRC" == true ] ; then
  	echo -e "\n========== $i ==========\n"
  	cat $i
  fi

  # If header, add the CheckDefine flag
  if [ "$file_type" ==  "h" ] ; then
    res=$(norminette -R CheckDefine $i)
  else
    res=$(norminette $i)
  fi

  if echo "$res" | awk '{print $2}' | grep -q  "OK!"; then
    echo -e "${GREEN}<< [$file_type] $res${NC}"
    OK=$(($OK + 1))
  else
    echo -e "${RED}<< [$file_type] $res${NC}"
    KO=$(($KO + 1))
  fi 
done

echo -e "\n<< OK: ${GREEN}$OK${NC}\tKO: ${RED}$KO${NC}\n"

if [ "$MAKE_BUILD" == true ] ; then
  if [ "$KO" == 0 ] ; then
    echo -e ">> Running make...\n"
  	make
  else
    echo -e "${RED}norminette failed, skipping make...${NC}"
  fi
fi