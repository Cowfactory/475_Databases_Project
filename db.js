var pg = require('pg');
pg.defaults.ssl = true;
var client = new pg.Client(process.env.DATABASE_URL);
client.connect();

function getAll(req, res, next) {
    var get = 'SELECT * FROM ' + req.params.table;

    client.query(get, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else {
            res.render(('pages/' + req.params.table), {
            result: result
            });
         }
    });
}

function createGame(req, res) {
    var insert = 'INSERT INTO GAMES VALUES($1, $2, $3, $4, $5, $6, $7, $8)';
    var values = [
        req.body.gameId,
        req.body.gameTitle,
        req.body.gamePublisher,
        req.body.gameGenre,
        (req.body.gameAge || undefined),
        (req.body.gameRating || undefined),
        (req.body.gameTime || undefined),
        1765];

    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/games');
        }
    });
}

function createMovie(req, res) {
    var insert = 'INSERT INTO MOVIES VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)';
    var values = [
        req.body.movieId,
        req.body.movieTitle,
        req.body.movieReleaseDate,
        req.body.movieDirector,
        req.body.movieGenre,
        req.body.movieTime,
        req.body.moviePublisher,
        (req.body.movieRating || undefined),
        (req.body.movieAge || 'UNR'),
        1765];

    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/movies');
        }
    });
}

function createEbook(req, res) {
    var insert = 'INSERT INTO EBOOKS VALUES($1, $2, $3, $4, $5, $6)';
    var values = [
        req.body.bookId,
        req.body.bookTitle,
        req.body.bookAuthor,
        req.body.bookPublisher,
        (req.body.bookRating || undefined),
        1765];
    
    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/ebooks');
        }
    });
}

function createCast(req, res) {
    var insert = 'INSERT INTO CASTLIST VALUES($1, $2, $3)';
    var values = [
        req.body.fName,
        req.body.lName,
        req.params.id,
    ];
    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/castlist/' + req.params.id);
        }
    });
}

function createMusic(req, res) {
    var insert = 'INSERT INTO MUSIC VALUES($1, $2, $3, $4, $5, $6, $7)';
    var values = [
        req.body.musicId,
        req.body.musicTitle,
        req.body.musicArtist,
        req.body.musicPublisher,
        (req.body.musicTime || undefined),
        (req.body.musicRating || undefined),
        1765];

    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/music');
        }
    });
}

function deleteMovie(req, res, next) {
    var del = 'DELETE FROM MOVIES WHERE movieId=' + req.params.id;

    client.query(del, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/movies');
        }
    });
}

function deleteGame(req, res, next) {
    var del = 'DELETE FROM GAMES WHERE gameId=' + req.params.id;

    client.query(del, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/games');
        }
    });
}

function deleteMusic(req, res, next) {
    var del = 'DELETE FROM MUSIC WHERE musicId=' + req.params.id;

    client.query(del, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/music');
        }
    });
}

function deleteEbook(req, res, next) {
    var del = 'DELETE FROM EBOOKS WHERE bookId=' + req.params.id;

    client.query(del, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/ebooks');
        }
    });
}

function deleteCast(req, res, next) {
    var del = 'DELETE FROM CASTLIST WHERE fName=$1 AND lName=$2 AND movieId=$3';
    var values = [
        req.params.fname,
        req.params.lname,
        req.params.id
    ];
    client.query(del, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/castlist/' + req.params.id);
        }
    })

}

function getMusic(req, res, next) {
    var query =  'SELECT * FROM MUSIC WHERE musicId=$1 OR ' +
                 'LOWER(title)=LOWER($2) OR ' + 
                 'LOWER(artist)=LOWER($3) OR ' + 
                 'LOWER(publisher)=LOWER($4) OR ' +
                 'playTime=$5 OR ' +
                 'starRating=$6';
    var values = [
        (req.query.musicId || null),
        (req.query.musicTitle || null),
        (req.query.musicArtist || null),
        (req.query.musicPublisher || null),
        (req.query.musicTime || null),
        (req.query.musicRating || null)];

    client.query(query, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.render(('pages/music'), {
                result: result
            });
        }
    });    
}

function getEBook(req, res, next) {
    var query = 'SELECT * FROM EBOOKS WHERE bookID=$1 OR ' + 
                'LOWER(title)=LOWER($2) OR ' + 
                'LOWER(author)=LOWER($3) OR ' + 
                'LOWER(publisher)=LOWER($4) OR ' +
                'starRating=$5';

    var values = [
        (req.query.bookId || null),
        (req.query.bookTitle || null),
        (req.query.bookAuthor || null),
        (req.query.bookPublisher || null),
        (req.query.bookRating || null)];
    
    client.query(query, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.render(('pages/ebooks'), {
            result: result
            });
        }
    });    
}

function getGame(req, res, next) {
    var query = 'SELECT * FROM GAMES WHERE gameID=$1 OR ' +
                 'LOWER(title)=LOWER($2) OR '+ 
                 'LOWER(publisher)=$3 OR ' + 
                 'LOWER(genre)=LOWER($4) OR ' + 
                 'LOWER(ageRating)=LOWER($5) OR ' + 
                 'starRating=$6 OR ' + 
                 'timePlayed=$7';
                 
    var values = [
        (req.query.gameId || null),
        (req.query.gameTitle || null),
        (req.query.gamePublisher || null),
        (req.query.gameGenre || null),
        (req.query.gameAge || null),
        (req.query.gameRating || null),
        (req.query.gameTime || null)];

    client.query(query, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.render(('pages/games'), {
            result: result
            });
        }
    });
}

function getMovie(req, res, next) {
    var insert = 'SELECT * FROM MOVIES WHERE movieId=$1 OR ' +
                 'LOWER(title)=LOWER($2) OR '+ 
                 'releaseDate=$3 OR ' + 
                 'LOWER(director)=LOWER($4) OR ' + 
                 'LOWER(genre)=LOWER($5) OR ' + 
                 'playTime=$6 OR ' + 
                 'LOWER(publisher)=LOWER($7) OR ' +
                 'starRating=$8 OR ' +
                 'LOWER(ageRating)=LOWER($9)';

    var values = [
        (req.query.movieId || null),
        (req.query.movieTitle || null),
        (req.query.movieReleaseDate || null),
        (req.query.movieDirector || null),
        (req.query.movieGenre || null),
        (req.query.movieTime || null),
        (req.query.moviePublisher || null),
        (req.query.movieRating || null),
        (req.query.movieAge || null)];

    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.render(('pages/movies'), {
            result: result
            });
        }
    });
}

function getCast(req, res) {
    var query = 'SELECT CASTLIST.Fname, CASTLIST.Lname, MOVIES.title, CASTLIST.movieId FROM CASTLIST, MOVIES WHERE CASTLIST.movieId=$1 AND MOVIES.movieId=CASTLIST.movieId';
    var movieId = [req.params.id];
    client.query(query, movieId, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.render('pages/castlist', {
                result: result,
                movieId: movieId
            });
        }
    });
}

module.exports = {
    getAll: getAll,
    createGame: createGame,
    createMovie: createMovie,
    createCast: createCast,
    createMusic: createMusic,
    createEbook: createEbook,
    deleteGame: deleteGame,
    deleteMovie: deleteMovie,
    deleteMusic: deleteMusic,
    deleteEbook: deleteEbook,
    deleteCast: deleteCast,
    getMusic: getMusic,
    getCast: getCast,
    getMovie: getMovie,
    getGame: getGame,
    getEBook: getEBook
};