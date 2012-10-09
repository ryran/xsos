xsos - Summarize system info from sosreports
============================================

The goal of `xsos` is to make it easy to gather information about a system together in an easy-to-read-summary, whether that system is the localhost or a system for which you have an unpacked sosreport.

There is tons of useful amazing instructive data available to normal users (not to mention root) on a Linux system, but by design, this information is spread out across myriad files. Some of it even requires commands to parse through.

`xsos` will attempt to make it easy, parsing and calculating and formatting data from dozens of files (and commands) to give you a detailed overview about a system, or -- if requested -- `xsos` will only parse one file (e.g. with `--mem`) or output from one command (e.g. with `--ip`).

New features are being added all the time -- see [the tracker](/ryran/xsos/issues) to have a look at some of the things that are already in line to be worked on.

**[Why another tool? Why not add stuff to `sxconsole`?](https://github.com/ryran/xsos/issues/9)**


INSTALLATION
-------

*"I'm sold"* you say. *"How do I install xsos?"* you say.  
Simply download [this one file](https://raw.github.com/ryran/xsos/master/xsos) and save it to a directory that's in your $PATH. You can even name the script whatever you want (like `x` or `z`). Make sure it's executable with a `chmod +x /PATH/TO/XSOS` and then run it with a `help` argument to get started!

Jump to ...

* [INSTALLATION](/ryran/xsos#installation)
* [EXAMPLES IN ACTION](/ryran/xsos#examples-in-action)
* [REQUIREMENTS](/ryran/xsos#requirements)
* [THINGS THAT MIGHT SURPRISE YOU](/ryran/xsos#things-that-might-surprise-you)
* [AUTHORS](/ryran/xsos#authors)
* [LICENSE](/ryran/xsos#license)


EXAMPLES IN ACTION
-------

Run on a sosreport with no options:

```
[rsaw@sawzall:~]$ xsos aczx998pinkle/
OS
  Hostname:  aczx998pinkle
  Distro:    Red Hat Enterprise Linux Server release 5.7 (Tikanga)
  Kernel:    2.6.18-274.18.1.el5
  Runlevel:  N 3 (default: 3)
  SELinux:   permissive via kernel args (default: enforcing)
  Sys time:  Thu Jun 28 16:07:20 EDT 2012
  Boot time: Thu Jun 28 18:59:55 EDT 2012 (1340909995)
  Uptime:    1:07,  3 users
  LoadAvg:   5.56 (23%), 3.10 (13%), 3.90 (16%)
  Cpu time since boot:
    us 3%, ni 0%, sys 1%, idle 87%, iowait 8%, irq 0%, sftirq 0%, steal 0%
  procs_running (procs_blocked):
    9 (1)
  Kernel taint-check: 64 1 
    Userspace-defined naughtiness
    Proprietary module has been loaded
  Kernel cmdline:
    ro root=/dev/rootvg/rootlv rhgb quiet crashkernel=512M@16M
  Kernel version/build:
    Linux version 2.6.18-274.18.1.el5 (mockbuild@x86-001.build.bos.redhat.com) 
    (gcc version 4.1.2 20080704 (Red Hat 4.1.2-51)) #1 SMP Fri Jan 20 15:11:18 
    EST 2012
-------------------------------------------------------------------------------
CPU
  24 logical processors (12 CPU cores)
  2 Intel Xeon CPU X5650 @ 2.67GHz (flags: ht,lm,pae,vmx)
  └─12 threads, 6 cores each
-------------------------------------------------------------------------------
MEMORY
  RAM:
    99.8g total [51.1g (51%) used]
    11.4g (11%) used excluding buffers/cache
    0.00g (0%) dirty
  HugePages:
    ZERO ram pre-allocated to HugePages
  LowMem/Slab/PageTables/Shmem:
    51.1g (51%) of 99.8g LowMem in-use
    0.90g (1%) of total ram used for Slab
    0.44g (0%) of total ram used for PageTables
  Swap:
    0.0g (0%) used of 96.0g total
-------------------------------------------------------------------------------
```


Run on localhost with a few options:

```
[rsaw@sawzall:~]$ sudo xsos --ip --ethtool --net
ETHTOOL
  em1         link=DOWN                        drv e1000e v2.0.0-k / fw 0.13-3
  tun0        link=UP 10Mb/s full (autoneg=N)  drv tun v1.6
  virbr0      link=DOWN                        drv bridge v2.3 / fw N/A
  virbr0-nic  link=DOWN                        drv tun v1.6
  wlan0       link=UP                          drv iwlwifi v3.5.3-1.fc17.x86_64 / fw 9.221.4.1
-------------------------------------------------------------------------------
IP
  Interface   Slave Of  MAC Address        State  IPv4 Address
  =========   ========  =================  =====  ==================
  lo          -         -                  up     127.0.0.1/8
  em1         -         f0:de:f1:ba:cf:c4  up     -
  wlan0       -         24:77:03:41:41:18  up     10.7.7.111/24
  virbr0      -         52:54:00:97:e3:ee  up     192.168.122.1/24
  virbr0-nic  -         52:54:00:97:e3:ee  DOWN   -
  tun0        -         -                  up     10.11.10.10/32
-------------------------------------------------------------------------------
NETDEV
  Interface   RxMBytes  RxPackets  RxErrs  RxDrop  TxMBytes  TxPackets  TxErrs  TxDrop
  =========   ========  =========  ======  ======  ========  =========  ======  ======
  em1         1110      1618247    0       0       508       1293102    0       0
  tun0        2         4681       0       0       0         4275       0       0
  virbr0      0         0          0       0       0         0          0       0
  virbr0-nic  0         0          0       0       0         0          0       0
  wlan0       456       485879     0       0       54        292131     0       0
-------------------------------------------------------------------------------
```


Run on another sosreport with some options:

```
[rsaw@sawzall:~]$ xsos 8308201prodserv --disks --mpath --mem --mb --lspci
MEMORY
  RAM:
    16051m total [15691m (97.8%) used]
    11955m (74.5%) used excluding buffers/cache
    45m (0.3%) dirty
  HugePages:
    8704m pre-allocated to HugePages (54.2% of total ram)
    1862m of HugePages (21.4%) in-use by applications
  LowMem/Slab/PageTables/Shmem:
    15691m (97.8%) of 16051m LowMem in-use
    101m (0.6%) of total ram used for Slab
    60m (0.4%) of total ram used for PageTables
  Swap:
    349m (8.3%) used of 4192m total
-------------------------------------------------------------------------------
STORAGE
  Multipath:
    archive    2.0 T
    dbbackup   850 G
    dgspool    20 G
    miscspool  100 G
    proddb     200 G
    prodstage  100 G
    produpgdb  150 G
    reportdb   30 G
    tsttrndev  150 G
  Disks:
    (Multipath and/or software raid components hidden)
    1 disks, totaling 272 GiB (0.27 TiB)
    sda   271.9 G
-------------------------------------------------------------------------------
LSPCI
  Net:
    8 NetXen Incorporated NX3031 Multifunction 1/10-Gigabit Server Adapter (rev 42) {2,4-port}
  VGA:
    Advanced Micro Devices [AMD] nee ATI ES1000 (rev 02)
-------------------------------------------------------------------------------
```


Run on a sosreport again, showing sysctls:

```
[rsaw@sawzall:~]$ xsos --sysctl aczx998pinkle/
SYSCTLS
  kernel.
    osrelease: 2.6.18-308.1.1.el5
    tainted: 64 1 
      Userspace-defined naughtiness
      Proprietary module has been loaded
    random.boot_id: 21b7cc17-587c-4cbf-87a4-XXXXXXXXXXXX
    random.entropy_avail: 3365
    panic: 0 (seconds til reboot after panic)
    hung_task_panic: 0
    panic_on_oops: 1
    panic_on_unrecovered_nmi: 0
    sysrq: 0
    sem: 250 32000 32 4096
      max semaphores per array = 250
      max sems system-wide     = 32000
      max ops per semop call   = 32
      max number of arrays     = 4096
    shmall (pages): 4294967296 (16384.0 G max total shared memory)
    shmmax (bytes): 4398046511104 (4096.00 G max segment size)
    shmmni (segments): 4096 (max number of segs)
  vm.
    dirty_ratio: 40 %
    dirty_background_ratio: 10 %
    dirty_bytes: 0 b
    dirty_background_bytes: 0 b
    dirty_expire_centisecs: 3000
    dirty_writeback_centisecs: 500
    nr_hugepages: 0 pages
    overcommit_memory: 0
    overcommit_ratio: 50 %
    panic_on_oom: 0
  net.
    ipv4.icmp_echo_ignore_all: 0
    ipv4.ip_forward: 0
    ipv4.tcp_max_orphans (sockets): 65536 (4096 M @ max 64 K per orphan)
    ipv4.tcp_mem (pages): 196608 262144 393216 (0.75 G, 1.00 G, 1.50 G)
    ipv4.udp_mem (pages): 24817344 33089792 49634688 (94.67 G, 126.23 G, 189.34 G)
    ipv4.tcp_rmem (bytes): 4096 87380 4194304 (4 K, 85 K, 4096 K)
    ipv4.tcp_wmem (bytes): 4096 16384 4194304 (4 K, 16 K, 4096 K)
    ipv4.udp_rmem_min (bytes): 4096 (4 K)
    ipv4.udp_wmem_min (bytes): 4096 (4 K)
-------------------------------------------------------------------------------
```


The help page:

```
[rsaw@sawzall:~]$ xsos help
Usage: xsos [-xKMabocmdpleins] [SOSREPORT-ROOT]
  or:  xsos [--B|--C|--M|--D|--L|--I|--N FILE]...
  or:  xsos [-?|-h|--help]
Extract useful data about system from SOSREPORT-ROOT or else localhost

Content options:
 -a, --all      show everything
 -b, --bios     show info from dmidecode
 -o, --os       show release, hostname, uptime, loadavg, cmdline
 -c, --cpu      show info from /proc/cpuinfo
 -m, --mem      show info from /proc/meminfo
 -d, --disks    show info from /proc/partitions
 -p, --mpath    show info from multipath
 -l, --lspci    show info from lspci
 -e, --ethtool  show info from ethtool
 -i, --ip       show info from ip addr (BASH v4+ required)
 -n, --net      show info from /proc/net/dev
 -s, --sysctl   show important kernel sysctls

Display options:
 -x, --nocolor  disable output colorization
 -K, --kb       show /proc/meminfo in KiB
 -M, --mb       show /proc/meminfo in MiB

Note that xsos argument parsing is performed by GNU getopt, so order of args
is not important (e.g. the SOSREPORT-ROOT could be the 1st argument).

If no content options are specified, xsos only shows some information,
equivalent to:

  xsos --os --cpu --mem
  
If SOSREPORT-ROOT isn't provided, the data will be gathered from the localhost;
however, bios, multipath, and ethtool output will only be displayed if running
as root (UID 0). When executing in this manner as non-root, those modules will
be silently skipped, even if explicitly requested.

Sometimes a full sosreport isn't available; sometimes you simply have a
dmidecode-dump or the contents of /proc/meminfo and you'd like a summary...

Special options (BASH v4+ required):
 --B=FILE  FILE must contain dmidecode dump
 --C=FILE  FILE must contain /proc/cpuinfo dump
 --M=FILE  FILE must contain /proc/meminfo dump
 --D=FILE  FILE must contain /proc/partitions dump
 --L=FILE  FILE must contain lspci dump
 --I=FILE  FILE must contain ip addr dump
 --N=FILE  FILE must contain /proc/net/dev dump

As is hopefully clear, each of these options requires a filename as an
argument. These options can be used together, but cannot be used in concert
with regular 'Content options' -- Content opts are ignored if Special options
are detected. Also note: the '=' can be replaced with a space if desired.

Re BASH v4+:
BASH associative arrays are used for various things. In short, if running xsos
on earlier BASH versions (e.g. RHEL5), you get ...
 * No output colorization
 * No -i/--ip
 * No parsing of 'Special options'

Version info: xsos v0.0.7 last mod 2012/10/07
Report bugs or suggestions to <rsaw@redhat.com>
Or see <github.com/ryran/xsos> for bug tracker & latest version
Alternatively, run xsos with '--update|-U'
```


Finally, here's example of using some of the Special options, which allow you to specify a specific file instead of a full sosreport or having `xsos` run on your local system:

```
[rsaw@sawzall:~]$ xsos --B /tmp/dmidecode.txt --I=/tmp/ipaddr.dump
DMIDECODE
  BIOS:
    HP, version P66, 06/24/2011
  System:
    Mfr:  HP
    Prod: ProLiant DL980 G7
    Vers: Not Specified
    Ser:  CZ3140XXXX      
    UUID: 35344D41-4131-5A43-3331-XXXXXXXXXXX
  CPU:
    8 of 8 CPU sockets populated, 8 cores/16 threads per CPU
    64 total cores, 128 total threads
    Mfr:  Intel
    Fam:  Xeon
    Freq: 2133 MHz
    Vers: Intel(R) Xeon(R) CPU E7- 2830 @ 2.13GHz 
  Memory:
    262144 MB (256 GB) total
    32 of 128 DIMMs populated (system max capacity 512 GB)
-------------------------------------------------------------------------------
IP
  Interface  Slave Of  MAC Address        State  IPv4 Address
  =========  ========  =================  =====  ==================
  lo         -         -                  up     127.0.0.1/8
  lo:0       -         -                  up     192.168.160.20/32
  eth0       -         ZZ:xy:56:01:12:qr  up     192.168.160.11/24
  eth1       -         ZZ:xy:9a:1a:19:qr  up     10.79.4.68/23
  eth1:1     -         ZZ:xy:9a:1a:19:qr  up     10.79.4.70/23
  eth2       -         ZZ:xy:28:fd:19:qr  up     10.10.10.8/28
  eth4       -         ZZ:xy:9e:0b:19:qr  up     192.168.254.8/28
  eth5       bond0     ZZ:xy:b5:0b:19:qq  up     -
  eth6       bond0     ZZ:xy:b5:0b:1a:qq  up     -
  eth7       -         ZZ:xy:35:00:99:qq  DOWN   -
  bond0      -         ZZ:zz:ZZ:zz:ZZ:zz  up     10.180.162.22/24
-------------------------------------------------------------------------------
```


REQUIREMENTS
-------

* As detailed in the help page, BASH version 4 (rhel 6+) is required for -i/--ip and for any of the "Special options" like `--C` or `--B`. Colorization is also not done unless BASH v4+ is detected.
* Other than that, nothing special for command requirements -- `xsos` uses standard coreutils & util-linux commands, along with, of course ... `gawk` and `sed`.
* No absolute paths used for commands.
* Gracefully reports as much of what's requested as possible when running as non-root.


THINGS THAT MIGHT SURPRISE YOU
-------

* `xsos` does some pretty intensive color-formatting to make the output more easily-readable (can be disabled with `-x` or `--nocolor`).
* `xsos` can update itself via the internet in 10 seconds if run with `--update` or `-U`.
* When printing disk info with `-d/--disks`, `xsos` automatically detects linux software raid (md) devices and hides their components.
* When run with `-m/--mpath`, the `multipath` command is consulted to print info about native multipathd devices. If using this option in concert with `-d/--disks`, all multipath device slave paths are also hidden from the disk output.
* When printing info on pci net devices (`-l/--lspci`), `xsos` simplifies the output in an intelligent way. Example:

```
[rsaw@server]$ lspci | grep Eth
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12)
05:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12)
0b:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
0b:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
0e:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
0e:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)

[rsaw@server]$ xsos -l
LSPCI
  Netdevs:
    2 Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12) {2,1-port}
    4 Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06) {2,2-port}
  Graphics:
    Advanced Micro Devices [AMD] nee ATI ES1000 (rev 02)
```


AUTHORS
-------

As far as direct contributions go, so far it's just me, [ryran](/ryran), aka rsaw, aka [Ryan Sawhill](http://b19.org).

However, people rarely accomplish things in a vacuum... I am very thankful to StackOverflow and a couple prolific users over there. [Dennis Williamson](http://stackoverflow.com/users/26428/dennis-williamson) and [ghostdog74](http://stackoverflow.com/users/131527/ghostdog74) have both offered answers containing pieces of code that were extremely instructive in helping me to advance my `awk` career.

Please contact me if you have ideas, suggestions, questions, or want to collaborate on this or something similar. For specific bugs and feature-requests, you can [post a new issue on the tracker](/ryran/xsos/issues).


LICENSE
-------

Copyright (C) 2012 [Ryan Sawhill](http://b19.org)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License @[gnu.org/licenses/gpl.html](http://gnu.org/licenses/gpl.html>) for more details.

