import socket
from termcolor import colored
import re

OWNERS = ['boesene', 'erik']
FILE = 'nodes.txt'

s = socket.socket()
host = socket.gethostname()
port = 2043
s.bind((host, port))

print('Listening on port %s...' % port)
print('-'*25)

s.listen(5)
while True:
    # Establish new connection
    c, addr = s.accept()
    # Store recieved data
    # Decode using cp1252 to prevent crash when recieving non-ASCII characters
    data = c.recv(1024).decode('cp1252')
    print('[REQ] {}'.format(data))
    # Filter out raw HTTP requests
    if data.count('\n') <= 1:
        try:
            req = re.search(r'^(\w+): ', data).group(0)[:-2]
            content = data[len(req)+2:]
        except AttributeError:
            req = None
            content = None
        if req == 'JOIN':
            # Don't write to file for join attempts from an owner
            if not any(owner in data for owner in OWNERS):
                print(colored('[SUC] Valid node accepted.', 'green'))
                # Write node data to file
                with open(FILE, 'a+') as f:
                    f.write(content + '\n')
            else:
                print(colored('[WRN] Ignoring join request from network owner.', 'yellow'))
            # Send response once node data has been stored
            c.send('[SRV] Node accepted.'.encode())
        elif req == 'UPDATE':
            # TODO: Automatically update data rather than writing to end of file
            with open(FILE, 'a+') as f:
                f.write(data + '\n')
            print(colored('[SUC] Node updated.', 'green'))
        elif req == 'INFO':
            pass
        else:
            print(colored('[INV] Invalid request.', 'red'))

    # Close the connection
    c.close()
