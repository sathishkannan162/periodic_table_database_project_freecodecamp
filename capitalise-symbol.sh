#!/bin/bash

PSQL="psql -X -U freecodecamp -d periodic_table --tuples-only -c"
echo -e "\n~~~Capitalise First letter in Symbols~~\n"

# get elements symbols 
ELEMENT_SYMBOLS=$($PSQL "SELECT symbol FROM elements");
echo "$ELEMENT_SYMBOLS" | while read SYMBOL 
do
#echo $SYMBOL | sed -r 's/^(\w)/\U\1/'
# symbol has first letter capital
if [[ ! $SYMBOL =~ ^[A-Z] ]]
# if not 
then
# capitalise
SYMBOL_CAP=$(echo $SYMBOL | sed -r 's/^(\w)/\U\1/')
# update symbols using single query if possible
INSERT_SYMBOL_RESULT=$($PSQL "UPDATE elements SET symbol='$SYMBOL_CAP' WHERE symbol='$SYMBOL'")
  if [[ $INSERT_SYMBOL_RESULT="UPDATE 1" ]]
  then 
    echo "Inserted $SYMBOL_CAP in place of $SYMBOL"
  fi
fi

done

