#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"


#no argument given
if [[ -z $1 ]] 
then
  echo Please provide an element as an argument.

else
  ATOMIC_NUMBER=
  # if arg is an atomic number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    #query elements.atomic_number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  # if arg is an element's symbol
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    #query elements.symbol
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  else
    #query elements.name
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  fi

  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo I could not find that element in the database.
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types LEFT JOIN properties USING(type_id) WHERE properties.atomic_number=$ATOMIC_NUMBER")
    MASS=$($PSQL "SELECT atomic_mass FROM types LEFT JOIN properties USING(type_id) WHERE properties.atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi
