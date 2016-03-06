var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

server = {
  start: function(){
    app.get('/', function(req, res){
      res.send('index.html');
    });
    io.on('connection', function(socket){
      console.log('a user connected');
    });
    http.listen(3000, function(){
      console.log('listening on *:3000');
    });
  }
}

module.exports = server;
