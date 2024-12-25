#!/bin/bash

# Connect to the interactive psql shell with psql --username=freecodecamp --dbname=postgres
# You can make a dump of it by entering pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql in a bash terminal 

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# creating the table
# create table users(user_id serial primary key, username varchar(22) not null unique);
# create table games(user_id serial primary key, games_played int not null default 0, best_game int)
# alter table games add constraint user_id_fk foreign key(user_id) references users(user_id);


# get username for user
echo "Enter your username:"
read USERNAME

# get user id
USER_ID=$($PSQL "SELECT USER_ID FROM users WHERE username = '$USERNAME';")

# if user doesnt exist    
if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # add user to db 
  $PSQL "INSERT INTO users(username) VALUES('$USERNAME');"
  # initiate game 
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")
  $PSQL "INSERT INTO GAMES(user_id) VALUES($USER_ID);" 
else 
  # if user does exist
  GAMES=$($PSQL "SELECT games_played, best_game FROM games WHERE user_id = $USER_ID;")
  echo "$GAMES" | while IFS="|" read GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

# generate random number for the game
RANDOM_NUMBER=$((RANDOM % 100 + 1));
# RANDOM_NUMBER=30 # for testing

# init guess count to zero
GUESS_COUNT=0;


MAIN_MENU() {
  if [[ $1 ]] 
  then
    echo -e "\n$1"
  fi

  read GUESS

  # if the guess is not a number
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    MAIN_MENU "That is not an integer, guess again:"
  else
    # increment guesss count
    GUESS_COUNT=$(($GUESS_COUNT+1))
    
    if [[ $GUESS -eq $RANDOM_NUMBER ]]; then
      # update database    
      GAMES=$($PSQL "SELECT games_played, best_game FROM games WHERE user_id = $USER_ID;")
      echo "$GAMES" | while IFS="|" read GAMES_PLAYED BEST_GAME
      do
        # if first game
        if [[ -z $BEST_GAME ]]; then
          # update first game
          $PSQL "UPDATE games SET games_played=1, best_game=$GUESS_COUNT WHERE user_id=$USER_ID;" 
        else
          # get new best game
          if [[ $GUESS_COUNT -lt $BEST_GAME ]]; then
            # update games played and guess count
            $PSQL "UPDATE games SET games_played=$(($GAMES_PLAYED + 1)), best_game=$GUESS_COUNT WHERE user_id=$USER_ID;" 
          else
            # update games played 
            $PSQL "UPDATE games SET games_played=$(($GAMES_PLAYED + 1)) WHERE user_id=$USER_ID;" 
          fi 
        fi
      done

      # end game
      echo -e "\nYou guessed it in $GUESS_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
      # exit 0;
    elif [[ $GUESS -gt $RANDOM_NUMBER ]]; then
      # try again
      MAIN_MENU "It's lower than that, guess again:"
    elif [[ $GUESS < $RANDOM_NUMBER ]]; then
      # try again  
      MAIN_MENU "It's higher than that, guess again:"
    fi
  fi

}

MAIN_MENU "Guess the secret number between 1 and 1000:"
