require 'socket'

server = TCPServer.open(2000)
loop {
  client = server.accept        # wait for the client to connect
  client.puts(Time.now.ctime)
  client.puts "Closing the connection. Goodbye!"
  client.close
}