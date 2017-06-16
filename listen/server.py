#!/usr/bin/python3

import os
import socket

ME = 'boesene'

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
    if ME not in data:  # Don't bother saving the data if it's just me testing
        with open('nodes.txt', 'a+') as f:
            f.write(data)

    resp = '[SERVER] Node %s accepted.' % data[:-1].replace(' ', '@')
    # We need to trim of the last newline character
    c.send(resp.encode())
    c.close()  # Close the connection
