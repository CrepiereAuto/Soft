var child_process = require('child_process');

start();

function start(){
  console.log('Open');
  var proc = child_process.spawn('node', ['server/server.js']);

  proc.stdout.on('data', (data) => {
    console.log(`${data}`);
  });
  proc.stderr.on('data', (data) => {
    console.log(`${data}`);
  });
  proc.on('exit', function (code) {
      console.log('Exit');
      delete(proc);
      setTimeout(start, 2000);
  });
}
