var express = require('express');
var pg = require('pg');
var app = express();
var bodyParser = require('body-parser')
var db = require('./db.js');

app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + '/public'));


app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.get('/', function(req, res) {
  res.render('pages/index');
});

pg.defaults.ssl = true;

app.get('/:table', db.getAll);

// Creates
app.post('/api/game', db.createGame);
app.post('/api/movie', db.createMovie);
app.post('/api/castlist', db.createCast);
app.post('/api/music', db.createMusic);
app.post('/api/ebook', db.createEbook);


// Deletes
app.get('/api/deleteGame/:id', db.deleteGame);
app.get('/api/deleteMovie/:id', db.deleteMovie);
app.get('/api/deleteMusic/:id', db.deleteMusic);
app.get('/api/deleteEbook/:id', db.deleteEbook);

// Search
//app.post('/search/movie', db.searchMovie);
app.get('/castlist/:id', db.getCast);

app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});


