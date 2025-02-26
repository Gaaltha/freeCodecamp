#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#Start fresh
echo $($PSQL "TRUNCATE games, teams")

#Insert into teams table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_G OPPONENT_G
do
  #Skip the header in games.csv
  if [[ $YEAR != year ]]
  then
    INSERT_WINNER_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER') ON CONFLICT DO NOTHING")
    # #Check if INSERT succeeded
    # if [[ $INSERT_WINNER_TEAMS_RESULT == "INSERT 0 1" ]]
    # then
    #   echo Inserted into teams, $WINNER
    # fi
    INSERT_OPP_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT') ON CONFLICT DO NOTHING")
    # #Check if INSERT succeeded
    # if [[ $INSERT_OPP_TEAMS_RESULT == "INSERT 0 1" ]]
    # then
    #   echo Inserted into teams, $OPPONENT
    # fi
    INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND',(SELECT team_id FROM teams WHERE name='$WINNER') , (SELECT team_id FROM teams WHERE name='$OPPONENT'), $WINNER_G, $OPPONENT_G)")
    # #Check if INSERT succeeded
    # if [[ $INSERT_GAMES_RESULT == "INSERT 0 1" ]]
    # then
    #   echo Inserted into games, $YEAR $WINNER vs $OPPONENT
    # fi
  fi
done


