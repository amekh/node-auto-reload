$(function(){
    socket = new WebSocket( 'ws://localhost:8125' );

    socket.onmessage = function( msg ) {
        window.location.reload();
    };

    socket.onopen = function() {
        socket.send("js-connect.");
    };
    
});
