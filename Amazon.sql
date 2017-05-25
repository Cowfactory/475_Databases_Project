--find out if CHECK constraint on starrating works, or if starRating must be initialzed to 0

--DROP TABLE CASTLIST;
--DROP TABLE EBOOKS;
--DROP TABLE GAMES;
--DROP TABLE MOVIE;
--DROP TABLE MUSIC;
--DROP TABLE ACCOUNT;


CREATE TABLE ACCOUNT (
    accID 		INT	            NOT NULL,
    Fname		VARCHAR(20)     NOT NULL,
    Lname		VARCHAR(20)     NOT NULL,
    region 		VARCHAR(50)     NOT NULL,
    age		    INT             DEFAULT(0),

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
        REFERENCES MOVIES(movieID)
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

--Sample data

--ACCOUNTS sample data
INSERT INTO ACCOUNTS 	
	VALUES (1765, ‘Carey’, ‘Roberts’, ‘Pacific Northwest’, 25);

--GAMES sample data
INSERT INTO GAMES 
	VALUES ( 0000001, ‘Final Fantasy VII’, ‘SQUARESOFT’, ‘RPG’, ‘T’, NULL, NULL);
INSERT INTO GAMES 
	VALUES ( 0000002, ‘Final Fantasy XV’, ‘SQUARE ENIX’, ‘RPG’, ‘T’, 5, 50:14:23);
INSERT INTO GAMES 
	VALUES ( 0000000, ‘BROKEN GAMEI’, ‘SQUARELUL’, ‘jRPG’, ‘T’, 6, NULL);

--MOVIES sample data
INSERT INTO MOVIES
	VALUES (5504, ‘Casablanca’, 11/26/1942, ‘Michael Curtiz’, ‘Drama Film, Romance’ , 01:42:67, ‘Hal B. Wallis’, 1765, ‘PG’, 5);

--MUSIC sample data	
INSERT INTO MUSIC 
	VALUES ( 7145, ‘Apologize’, ‘One Republic’ , ‘Greg Wells’, 00:03:28, 5, 1765);


--EBOOKS sample data