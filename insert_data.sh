#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #Insert teams table data 

  #Get winner team name 

    #exclude column name 
    if [[ $WINNER != "winner" ]]
    then
        #get team name
        TEAM1_NAME=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
         #if team name is not found, we need to include the new team to the table
        if [[ -z $TEAM1_NAME ]] # -z == is null
        then 
        INSERT_TEAM1_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ")
            if [[ $INSERT_TEAM1_NAME == "INSERT 0 1" ]]
            then
              echo Inserted team $WINNER
            fi
        fi
    fi
    
  #Get opponent team name

    #exclude column name
    if [[ $OPPONENT != "opponent" ]]
    then
      #get opponent name
      TEAM2_NAME=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
      #if name is not found, we need to insert new name into the table
        if [[ -z $TEAM_NAME ]] #-z == is null
        then
          INSERT_TEAM2_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            if [[ $INSERT_TEAM2_NAME == "INSERT 0 1" ]]
            then 
              echo Inserted team $OPPONENT
            fi
        fi
    fi
    
  # insert gama table data
    #exclude column name
    if [[ YEAR != "year" ]]
      then
        #get winner_id
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        #get opponent_id
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        #insert new game row
        INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS) ")
          #echo to tell if it was added
          if [[ $INSERT_GAME == "INSERT 0 1" ]]
          then
            echo New game added:
          fi
    fi
    
done
