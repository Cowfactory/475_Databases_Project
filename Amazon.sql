--find out if CHECK constraint on starrating works, or if starRating must be initialzed to 0

--DROP TABLE ACCOUNT;
--DROP TABLE CASTLIST;
--DROP TABLE EBOOKS;
--DROP TABLE GAMES;
--DROP TABLE MOVIES;
--DROP TABLE MUSIC;

CREATE TABLE ACCOUNT (
    accID INT	            NOT NULL,
    Fname		VARCHAR(20)     NOT NULL,
    Lname		VARCHAR(20)     NOT NULL,
    region 		VARCHAR(50)     NOT NULL,
    age		    INT             DEFAULT(0)

    PRIMARY KEY (accID)
);

CREATE TABLE GAMES(
    gameID 	    INT			    NOT NULL,
    title 		VARCHAR(50) 	NOT NULL,
    publisher 	VARCHAR(50) 	NOT NULL,
    genre 		VARCHAR(20) 	NOT NULL,
    ageRating 	VARCHAR(5),
    starRating 	INT,
    timePlayed 	TIME,
    accID       INT             NOT NULL,

    PRIMARY KEY (gameID),
    FOREIGN KEY (accID) 
        REFERENCES ACCOUNT(accID)
        ON UPDATE CASCADE,
    CHECK (starRating >= (1) AND starRating <= (5)),
    CHECK (ageRating = ('eC') OR ageRating = ('E') OR 
           ageRating = ('E10') OR ageRating = ('T')  OR
           ageRating = ('M')  OR ageRating = ('Ao'))
);

CREATE TABLE MOVIES(
    movieID 		INT			    NOT NULL,
    title 			VARCHAR(50) 	NOT NULL,
    releaseDate 	DATE		    NOT NULL,
    director		VARCHAR(15) 	NOT NULL,
    genre 			VARCHAR(15) 	NOT NULL,
    playTime 		TIME	 		NOT NULL,
    publisher 		VARCHAR(15) 	NOT NULL,
    accID 			INT 			NOT NULL,
    starRating 		INT,
    ageRating       VARCHAR(5),
    PRIMARY KEY (movieID),
    FOREIGN KEY (accID) 
        REFERENCES ACCOUNT(accID) 
        ON UPDATE CASCADE,
    CHECK (starRating >= 1 AND starRating <= 5),
    CHECK (ageRating = ('eC') OR ageRating = ('E') OR 
          ageRating = ('E10') OR ageRating = ('T')  OR 
          ageRating = ('M')  OR ageRating = ('Ao'))
);

CREATE TABLE CASTLIST(
	Fname		VARCHAR(20) NOT NULL,
	Lname		VARCHAR(20) NOT NULL,
	movieID	    INT,
	FOREIGN KEY (movieID)
        REFERENCES MOVIE(movieID)
        ON UPDATE CASCADE
);

CREATE TABLE MUSIC(
    musicID	    INT	        NOT NULL,
    title 		VARCHAR(50) NOT NULL,
    artist 		VARCHAR(50) NOT NULL,
    publisher 	VARCHAR(50) NOT NULL,
    playTime	TIME,
    starRating	INT,
    accID		INT,
    PRIMARY KEY (musicID),
    FOREIGN KEY (accID) 
        REFERENCES ACCOUNT(accID)
        ON UPDATE CASCADE,
    CHECK (starRating >= (1) AND starRating <= (5))
);

CREATE TABLE EBOOKS(
	bookID		INT	NOT NULL,
	title 		VARCHAR(50) NOT NULL,
	author		VARCHAR(50) NOT NULL,
	publisher	VARCHAR(50) NOT NULL,
	starRating	INT,
	accID		INT,
	PRIMARY KEY (bookId),
	FOREIGN KEY (accID) 
        REFERENCES ACCOUNT(accID)
        ON UPDATE CASCADE,
	CHECK	(starRating >= 1 AND starRating <= 5)
);