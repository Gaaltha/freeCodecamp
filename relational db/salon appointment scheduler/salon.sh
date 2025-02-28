#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~~ Gaaltha's ~~~~~~\n"


MAKE_APPOINTMENT() {
  # print argument if given
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  #get list of services
  echo -e "\nWhat would you like?"
  SERVICES_LIST=$($PSQL "SELECT * FROM services ORDER BY service_id")
  echo "$SERVICES_LIST" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done

  read SERVICE_ID_SELECTED
  #if service not it the list
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ || $SERVICE_ID_SELECTED -eq 0 || $SERVICE_ID_SELECTED -gt $($PSQL "SELECT COUNT(*) FROM services") ]]
  then
    MAKE_APPOINTMENT "Sorry, your choice is not in the list."
  else
    #get customer phone number
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    
    #get customer_id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    #if new customer
    if [[ -z $CUSTOMER_ID ]]
    then
      #get customer name
      echo -e "\nI have no record for that number. Can I get your name?"
      read CUSTOMER_NAME
      #insert into customers
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      #get new customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    else
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    fi
    FORMAT_CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')
    
    #get appointment hour
    echo -e "\nWhat time would you like your appointment, $FORMAT_CUSTOMER_NAME?"
    read SERVICE_TIME

    #insert into appointments
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    FORMAT_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED" | sed -E 's/^ *| *$//g')
    echo -e "\nI have put you down for a $FORMAT_SERVICE_NAME at $(echo $SERVICE_TIME | sed -E 's/^ *| *$//g'), $FORMAT_CUSTOMER_NAME."
  fi
}

MAKE_APPOINTMENT
