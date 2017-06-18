import socket

OWNER = 'boesene'

s = socket.socket()
host = socket.gethostname()
port = 2043
s.bind((host, port))

print('Listening on port %s...' % port)
s.listen(5)
while True:
    # Establish new connection
    c, addr = s.accept()
    # Store recieved data
    data = c.recv(1024).decode()
    # Filter raw HTTP requests
    if data.count('\n') <= 1:
        # Ignore join attempts from owner
        if OWNER not in data:
            print('Node has joined: %s' % data, end='')
            # Write node data to file
            with open('nodes.txt', 'a+') as f:
                f.write(data)
        else:
            print('Ignoring join attempt from node identified as owner\'s computer.')
        # Send response once node data has been stored
        c.send('[SERVER] Node accepted, may hibernate.'.encode())
    # Close the connection
    c.close()
