import socket

OWNERS = ['boesene', 'erik']

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
        print('Node has requested to join: %s' % data)
        # Don't write to file for join attempts from an owner
        if not any(owner in data for owner in OWNERS):
            print('Qualified node has been accepted.')
            # Write node data to file
            with open('nodes.txt', 'a+') as f:
                f.write(data + '\n')
        else:
            print('Not writing node identified as owner\'s computer.')
        # Send response once node data has been stored
        c.send('[SERVER] Node accepted, may hibernate.'.encode())
    # Close the connection
    c.close()
