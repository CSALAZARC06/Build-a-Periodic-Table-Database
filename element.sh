#!/bin/bash

#Elements library

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $# -eq 0 ]]; then
    echo "Please provide an element as an argument."
    exit 0  # Exit the script with a non-zero status
fi
ELEMENT_ARGUMENT="$1"

if [[ $ELEMENT_ARGUMENT =~ ^[0-9]+$ ]]
then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number=$ELEMENT_ARGUMENT" | xargs)

  if [[ -z $ATOMIC_NUMBER ]]; then
    echo "I could not find that element in the database."
  
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID" | xargs)

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."

  fi

elif [[ $ELEMENT_ARGUMENT =~ ^[a-zA-Z]{1,2}$ ]]
then

  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$ELEMENT_ARGUMENT'" | xargs)

  if [[ -z $SYMBOL ]]; then
    echo "I could not find that element in the database."
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT_ARGUMENT'" | xargs)
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID" | xargs)

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."

  fi

elif [[ $ELEMENT_ARGUMENT =~ ^[a-zA-Z]+$ ]]
then

  NAME=$($PSQL "SELECT name FROM elements WHERE name='$ELEMENT_ARGUMENT'" | xargs)

  if [[ -z $NAME ]]; then
    echo "I could not find that element in the database."
  
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELEMENT_ARGUMENT'" | xargs)
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID" | xargs)

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."

  fi

else
  echo "I could not find that element in the database."
fi