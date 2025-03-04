#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess --no-align --tuples-only -c"

MAIN_FUNC() {
  echo -e "\nEnter your username:"
  read USERNAME

  #get player_id
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username='$USERNAME'")
  #new player
  if [[ -z $PLAYER_ID ]]
  then
    #insert into table players
    INSERT_NEW_PLAYER=$($PSQL "INSERT INTO players(username) VALUES ('$USERNAME')")
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  #returning player
  else
    #get player info
    GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games LEFT JOIN players USING(player_id) WHERE player_id=$PLAYER_ID")
    BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games LEFT JOIN players USING(player_id) WHERE player_id=$PLAYER_ID")
    echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
  
  #generate a random number between 1 and 1000 included
  TO_GUESS=$(( 1 + $RANDOM % 1000 ))
  
  #call number gessing function
  echo -e "\nGuess the secret number between 1 and 1000:"
  GUESS_NUMBER
}


GUESS_NUMBER() {
  read PLAYER_GUESS
  NUMBER_OF_GUESSES=1
  
  while [[ $PLAYER_GUESS != $TO_GUESS ]]
  do
    #PLAYER_GUESS is not an integer
    if [[ $PLAYER_GUESS =~ [[:alpha:]*[:punct:]*] ]]
    then
      echo -e "\nThat is not an integer, guess again:"
      read PLAYER_GUESS
    #PLAYER_GUESS > TO_GUESS
    elif [[ $PLAYER_GUESS -gt $TO_GUESS ]]
    then
      NUMBER_OF_GUESSES=$(( NUMBER_OF_GUESSES + 1 ))
      echo -e "\nIt's lower than that, guess again:"
      read PLAYER_GUESS

    #PLAYER_GUESS < TO_GUESS
    elif [[ $PLAYER_GUESS -lt $TO_GUESS ]]
      then
      NUMBER_OF_GUESSES=$(( NUMBER_OF_GUESSES + 1 ))
      echo -e "\nIt's higher than that, guess again:"
      read PLAYER_GUESS
    fi
  done
  #PLAYER_GUESS is right 
  echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $TO_GUESS. Nice job!"
  #insert game into games table
  INSERT_GAME=$($PSQL "INSERT INTO games(player_id, guesses) VALUES ((SELECT player_id FROM players WHERE username='$USERNAME'), $NUMBER_OF_GUESSES)")
}

MAIN_FUNC
