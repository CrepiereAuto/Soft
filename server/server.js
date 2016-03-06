var app = require('express')();
  http = require('http').Server(app);
  io = require('socket.io')(http);
  git = require('simple-git')();
  gulp = require('./../Gulpfile');

app.get('/', function(req, res){
  res.send('index.html');
});

app.get('/git/pull', function(req, res){
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
  res.sendFile('SoftPI.zip');
});

io.on('connection', function(socket){
  console.log('A user connected');
});

http.listen(3030, function(){
  console.log('Listening *:3030');
});
