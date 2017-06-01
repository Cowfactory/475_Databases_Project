--QUERIES

--Games
--Request games that belong to a certain AgeRating.
SELECT * FROM GAMES WHERE AgeRating = <query>;

--Request all played games sorted by star rating.
SELECT * FROM GAMES ORDER BY starRating;

--Music
--View all music sorted by play time.
SELECT * FROM MUSIC ORDER BY playTime;
 
--View all music sorted by star rating.
SELECT * FROM MUSIC ORDER BY starRating;

--Movies
--View all movies belonging to a certain genre.
--double check that this works
SELECT * FROM MOVIES WHERE genre = <query>;

--View all movies sorted by star rating.
SELECT * FROM MOVIES ORDER BY starRating;

--EBooks
--Look up a book based on name.
SELECT * FROM EBOOKS WHERE EBOOKS.title = <query>;
 
--View all books belonging to a specific genre.
SELECT EBOOKS.title FROM EBOOKS WHERE EBOOKS.genre = <query>;

--View all books owned sorted by star rating.
SELECT EBOOKS.title FROM EBOOKS WHERE EBOOKS.id = <accId> AND EBOOKS.starRating=<1-5>;

--View all e-books written by a specified author.
SELECT * FROM EBOOKS WHERE EBOOKS.author = <query>;

--View all cast involved with a specific movie
SELECT * FROM CASTLIST WHERE CASTLIST.MovieID = MOVIES.MovieID AND MOVIES.movieID = <query>;
 
--View all cast with the last name DiCaprio 
SELECT * FROM CASTLIST WHERE CASTLIST.Lname='DiCaprio';
 
--View all cast in a specific genre
SELECT CASTLIST.Fname, CASTLIST.Lname FROM CASTLIST, MOVIES WHERE CASTLIST.movieID = MOVIE.movieID  AND MOVIE.genre = <query>;
 
--View all cast in a movie released in 2000
SELECT CASTLIST.Fname, CASTLIST.Lname FROM CASTLIST, MOVIES WHERE MOVIE.releaseDate > ‘1999-12-31’ AND MOVIE.releaseDate <’2001-1-1’ AND CASTLIST.movieID = MOVIE.movieID;
 
