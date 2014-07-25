require 'socket'

host = 'www.tutorialspoint.com'
port = 80
path = "/index.htm"

# http request we send to fetch a file
request = "GET #{path} HTTP\1.0\r\n\r\n"

socket = TCPSocket.open(host,port)    # connect to server
socket.print(request)                 # sent request
response = socket.read                # read complete response
# split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
print body