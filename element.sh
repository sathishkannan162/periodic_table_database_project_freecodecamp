#!/bin/bash

PSQL="psql -X -U freecodecamp -d periodic_table --tuples-only -c"
# if arg is not empty
if [[ $1 ]]
then 
  # check arg type
  # check atomic_number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    # check in database
    ELEMENT_INFO=$($PSQL "SELECT atomic_number,name,symbol,types.type,atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1")
    
     if [[ -z $ELEMENT_INFO ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_PT BAR BOILING_PT
      do 
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
      done
    fi

  elif [[ $1 =~ ^[A-Z][A-Za-z]{0,1}$ ]]
  # check symbol
  then 
    # check in database
    ELEMENT_INFO=$($PSQL "SELECT atomic_number,name,symbol,types.type,atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$1'")
    if [[ -z $ELEMENT_INFO ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_PT BAR BOILING_PT
      do 
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
      done
    fi
  else 
  # otherwise name
  
  # check in database
    ELEMENT_INFO=$($PSQL "SELECT atomic_number,name,symbol,types.type,atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$1'")
    
     if [[ -z $ELEMENT_INFO ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT_INFO" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_PT BAR BOILING_PT
      do 
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_PT celsius and a boiling point of $BOILING_PT celsius."
      done
    fi

    
  fi
  
else
# if arg is empty
  echo "Please provide an element as an argument."
fi
