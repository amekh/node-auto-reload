var http = require('http');
var io = require('socket.io');

var server = http.createServer();
server.listen(8124);
var socket = io.listen(server);

var count = 0;
var mclient;

socket.on('connection', function(client){
  mclient = client;
  count++;
  client.emit('user connected', count);
  client.broadcast.emit('user connected', count);
  client.on('message', function(event){
    console.log(event.message);
    client.emit('message', event.message);
    client.broadcast.emit('message', event.message);
  });
  client.on('disconnect', function() {
    count--;
    client.emit('user disconnected', count);
    client.broadcast.emit('user disconnected', count);
  });  
});

var net = require('net');

var tcp_server = net.createServer(function(socket){
  socket.setEncoding('utf8');

  socket.write('hello\r\n');

  socket.on('data', function(){
    socket.write('bb');
    mclient.emit('message', "<script>window.location.reload(true);</script>");
    mclient.broadcast.emit('message', "<script>window.location.reload(true);</script>");
  });

  socket.on('end', function(){
    console.log('server disconnected');
  });
});
tcp_server.listen(8125, "localhost");
