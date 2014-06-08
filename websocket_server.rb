
require 'socket'
require 'em-websocket'

connections = Array.new

EventMachine::WebSocket.start( :host => '0.0.0.0', :port => 8125 ) do |web_socket|
  
  web_socket.onopen do
    connections.push( web_socket ) unless connections.index( web_socket )
  end

  web_socket.onmessage do |msg|
    puts "received" + msg
    connections.each do |conn|
      conn.send(msg) if conn != web_socket
    end
  end

end

