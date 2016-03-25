var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
// var p2p = require('socket.io-p2p-server').Server;
var git = require('simple-git')();
var gulp = require('./../Gulpfile');
// var p2pMdwr = require('./p2p');
var manager = require('./manager')

http.listen(3030, function(){console.log('Listening *:3030');});

app.get('/', function(req, res){
  res.send('index.html');
});

app.post('/git/pull', function(req, res){
  res.send('ok');
  git.pull(function(err, update) {
   if(update && update.summary.changes) {
     console.log('Updating...');
     gulp.start('make', function(){
       console.log('Done.');
       process.exit(1);
     });
   }else {
     console.log('Already update');
   }
 });
});

app.get('/download', function(req, res){
  var file = __dirname + '/../SoftPI.zip';
  res.download(file);
});

io.on('connection', function(socket){
  socket.on('disconnect', function(){
    manager.stop(socket.id)
  })

  socket.on('start', function(data) {
    manager.start(socket, data)
  })

  socket.on('open', function (data) {
    manager.open(socket, data)
  })

  socket.on('join', function (data) {
    manager.join(socket, data)
  })

})
