#!/usr/bin/python3

import os
import socket

s = socket.socket()         # Create a socket object
host = socket.gethostname()  # Get local machine name
port = 2043                 # Reserve a port for your service.
s.bind((host, port))        # Bind to the port

print('Listening on port %s...' % port)
s.listen(5)
while True:
    c, addr = s.accept()    # Establish connection with client.
    print('Got connection from %s:%s' % addr)
    data = c.recv(1024).decode()
    print('New node online: %s' % data, end='')
    with open('nodes.txt', 'a+') as f:
        f.write(data)

    resp = '[SERVER] Information for %s recorded. Node may disconnect.' % data[:-1].replace(' ', '@')
    # We need to trim of the last newline character
    c.send(resp.encode())
    c.close() # Close the connection
