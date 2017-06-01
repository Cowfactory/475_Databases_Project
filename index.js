var express = require('express');
var pg = require('pg');
var app = express();

app.set('port', (process.env.PORT || 5000));

app.use(express.static(__dirname + '/public'));

// views is directory for all template files
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.get('/', function(request, response) {
  response.render('pages/index');
});

pg.defaults.ssl = true;

app.get('/:table', function (req, res) {
  pg.connect(process.env.DATABASE_URL, function(err, client, done) {
    if (err) { console.error('err'); }

    client.query(('SELECT * FROM ' + req.params.table), function (err, result) {
      done();
      if (err) {
        console.error(err);
        res.send('Error ' + err);
      }
      else {
        res.render(('pages/' + req.params.table), {
          result: result
        });
        console.log(result);

      }
    });
  });
});



app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});


