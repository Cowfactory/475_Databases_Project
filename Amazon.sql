--find out if CHECK constraint on starrating works, or if starRating must be initialzed to 0

DROP TABLE CASTLIST;
DROP TABLE EBOOKS;
DROP TABLE GAMES;
DROP TABLE MOVIES;
DROP TABLE MUSIC;
DROP TABLE ACCOUNT;


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
    starRating 		INT,
    ageRating       VARCHAR(5)      DEFAULT('UNR'),
    accID 			INT 			NOT NULL,
    PRIMARY KEY (movieID),
    FOREIGN KEY (accID) 
        REFERENCES ACCOUNT(accID) 
        ON UPDATE CASCADE,
    CHECK (starRating >= 1 AND starRating <= 5),
    CHECK (ageRating = ('G') OR ageRating = ('PG') OR 
	ageRating = ('PG-13') OR ageRating = ('R')  
	OR ageRating = ('NC-17')  OR ageRating = ('UNR'))
);

CREATE TABLE CASTLIST(
	Fname		VARCHAR(20) NOT NULL,
	Lname		VARCHAR(20) NOT NULL,
	movieID	    INT         NOT NULL,
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
	accID		INT         NOT NULL,
	PRIMARY KEY (bookId),
	FOREIGN KEY (accID) 
        REFERENCES ACCOUNT(accID)
        ON UPDATE CASCADE,
	CHECK	(starRating >= 1 AND starRating <= 5)
);

--Sample data

--ACCOUNTS sample data
INSERT INTO ACCOUNT 	
	VALUES (1765, 'Carey', 'Roberts', 'Pacific Northwest', 25);

--GAMES sample data
INSERT INTO GAMES 
<<<<<<< HEAD
	VALUES ( 0000001, 'Final Fantasy VII', 'SQUARESOFT', 'RPG', 'T', NULL, NULL, 1);
INSERT INTO GAMES 
	VALUES ( 0000002, 'Final Fantasy XV', 'SQUARE ENIX', 'RPG', 'T', 5, '50:14:23', 1);
INSERT INTO GAMES 
	VALUES ( 0000003, 'Mature Game', 'SQUARELUL', 'jRPG', 'M', 3, NULL, 1);
INSERT INTO GAMES
	VALUES ( 0000004, 'FIFA 15', 'EA SPORTS',  'Sports', 'E', 4, '4:14:45', 1); 
	
--MOVIES sample data
INSERT INTO MOVIES
	VALUES (5504, 'Casablanca', '1942-11-26', 'Michael Curtiz', 'Drama Film, Romance' , '01:42:67', 'Hal B. Wallis', 1, 5, 'PG');
=======
	VALUES ( 1, 'Final Fantasy VII', 'SQUARESOFT', 'RPG', 'T', NULL, NULL, 1765);
INSERT INTO GAMES 
	VALUES ( 2, 'Final Fantasy XV', 'SQUARE ENIX', 'RPG', 'T', 5, '02:14:23', 1765);
INSERT INTO GAMES 
	VALUES ( 3, 'Mature Game', 'SQUARELUL', 'jRPG', 'M', 3, NULL, 1765);

--MOVIES sample data
INSERT INTO MOVIES
	VALUES (5504, 'Casablanca', '1942-11-26', 'Michael Curtiz', 'Drama, Romance' , '01:42:57', 'Hal B. Wallis', 5, 'PG', 1765);
>>>>>>> origin/master

--MUSIC sample data	
INSERT INTO MUSIC 
	VALUES ( 7145, 'Apologize', 'One Republic' , 'Greg Wells', '00:03:28', 5, 1);


--EBOOKS sample data

INSERT INTO EBOOKS
	VALUES(1566, 'Lion', 'Saroo Brierley', 'Joseph Ellis', 5, 1);
INSERT INTO EBOOKS
<<<<<<< HEAD
	VALUES(1567, 'Sully', 'Harper Collins', 'Jeffrey Zaslow', 5, 1);
INSERT INTO EBOOKS
	VALUES(1568, 'Hidden Figures', 'Margot Lee', 'Arthur Zelizer', 5, 1);

--CASTLIST sample data
INSERT INTO CASTLIST 
	VALUES ('Humphrey', 'Bogart', 1);
INSERT INTO CASTLIST
	VALUES ('Daniel', 'Radcliffe', 1);
INSERT INTO CASTLIST
	VALUES('Leonardo', 'DiCaprio', 1);
=======
	VALUES(1567, 'Sully', 'Harper Collins', 'Jeffrey Zaslow', 5, 1765);
INSERT INTO EBOOKS
	VALUES(1568, 'Hidden Figures', 'Margot Lee', 'Arthur Zelizer', 5, 1765);

--CASTLIST sample data
INSERT INTO CASTLIST 
	VALUES ('Humphrey', 'Bogart', 5504);
INSERT INTO CASTLIST
	VALUES ('Daniel', 'Radcliffe', 5504);
INSERT INTO CASTLIST
	VALUES('Leonardo', 'DiCaprio', 5504);
>>>>>>> origin/master

	
	


