# CSS 475 Project

https://css475project.herokuapp.com
## Overview 
The database we are creating represents the contents of a single user’s Amazon Prime account’s media library, including their games, movies, music, books, and associated metadata. Accessing the contents of the database gives us the list of various media owned by the account. By narrowing down the scope of our searches, we can isolate various data, such as what star rating a user has given a movie, or their playtime on a specific video game.
 
Our database’s scope is limited to a single user’s media, and contains various associated attributes such as star rating, and play time. This means the cardinality for many parts of the database will be 1:N.

## Requirements
* NodeJS
* PostgreSQL
* Heroku CLI

## Running app locally
Note: `.env` file needs be included in the root of the directory
1. Clone project
2. Within project directory, run `npm install`
3. Run `heroku local`
4. Navigate to `localhost:5000` in browser