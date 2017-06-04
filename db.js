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
        req.body.movieId,
    ];

    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.redirect('/castlist');
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

function searchMovie(req, res, next) {
    var insert = 'SELECT * FROM MOVIES WHERE movieId=$1 OR title=$2 OR releaseDate=$3 OR director=$4 OR genre=$5 OR playTime=$6 OR publisher=$7 OR starRating=$8 OR ageRating=$9';
    var values = [
        req.body.movieId,
        req.body.movieTitle,
        (req.body.movieReleaseDate || undefined),
        req.body.movieDirector,
        req.body.movieGenre,
        (req.body.movieTime || undefined),
        req.body.moviePublisher,
        (req.body.movieRating || undefined),
        (req.body.movieAge)];

    client.query(insert, values, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.send(result);
        }
    });
}

function getCast(req, res) {
    var query = 'SELECT * FROM CASTLIST WHERE movieId=$1';
    var movieId = [req.params.id];
    client.query(query, movieId, function (err, result) {
        if (err) {
            res.render('pages/error', {
                err: err
            });
        } else if (result) {
            res.render('pages/castlist', {
                result: result
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
    getCast: getCast
};