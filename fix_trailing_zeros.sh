#!/bin/bash

PSQL="psql -X -U freecodecamp -d periodic_table --tuples-only -c"
echo -e "\n~~ Fix trailing zeros in Atomic mass ~~\n"

# query the atomic mass with atomic number as atomic number is unique.
echo "$($PSQL "SELECT atomic_number, atomic_mass FROM properties")" | while read ATOMIC_NUMBER BAR ATOMIC_MASS
do 
# check whether it has trailing zeros
# all values have trailing zeros, no need to check for now. modify if needed.
ATOMIC_MASS=$(echo $ATOMIC_MASS | sed 's/0*$//')

# Update atomic mass with atomic number as id.
UPDATE_RESULT=$($PSQL "UPDATE properties SET atomic_mass=$ATOMIC_MASS WHERE atomic_number=$ATOMIC_NUMBER")

if [[ UPDATE_RESULT=="UPDATE 1" ]]
then
echo "Updated atomic mass for $ATOMIC_NUMBER: $ATOMIC_MASS"
fi

done


