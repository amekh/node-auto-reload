$(function(){
  var socket = new io.connect("http://localhost:8124");
  socket.on('message', function(message){
    $('body').append(message);
  });
});
