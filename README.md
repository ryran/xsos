xsos - Summarize system info from sosreports
============================================

The goal of `xsos` is to make it easy to instantaneously gather information about a system together in an easy-to-read-summary, whether that system is the localhost or a system for which you have an unpacked sosreport.

There is tons of useful amazing instructive data available to normal users (not to mention root) on a Linux system, but by design, this information is spread out across myriad files. Some of it even requires commands to parse through.

`xsos` will attempt to make it easy, parsing and calculating and formatting data from dozens of files (and commands) to give you a detailed overview about a system, or -- if requested -- `xsos` will only parse one file (e.g. with `--mem` or `--cpu`) or output from one command (e.g. with `--ip` or `--ps`).

New features are being added all the time -- see [the tracker](/ryran/xsos/issues) to have a look at some of the things that are already in line to be worked on.

**[Why another tool? Why not add stuff to `sxconsole`?](https://github.com/ryran/xsos/issues/9)**


INSTALLATION
-------

*"I'm sold! How do I install xsos?"*
Simply download [this one file](https://raw.github.com/ryran/xsos/master/xsos) and save it to a directory that's in your $PATH. You can even name the script whatever you want (like `x` or `z`). Make sure it's executable with a `chmod +x /PATH/TO/XSOS` command and then run it with a `help` argument to get started!

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
[rsaw@sawzall]$ xsos aczx998pinkle/
OS
  Hostname:  aczx998pinkle
  Distro:    Red Hat Enterprise Linux Server release 5.5 (Tikanga)
  Kernel:    2.6.18-194.26.1.el5
  Arch:      mach=x86_64  cpu=x86_64  platform=x86_64
  Runlevel:  3 5  (default 3)
  SELinux:   permissive  (default enforcing)
  Sys time:  Thu Jun 28 12:09:05 CDT 2012
  Boot time: Thu Jun 28 07:29:14 CDT 2012 (1340868554)
  Uptime:    9:39, 16 users
  LoadAvg:   120.46 (94%), 95.32 (74%), 50.82 (40%)
  Cpu time since boot:
    us 6%, ni 0%, sys 2%, idle 74%, iowait 18%, irq 0%, sftirq 1%, steal 0%
  procs_running (procs_blocked):
    5 (0)
  Kernel taint-check: 536870912 512 64 16 1
    Technology Preview code is loaded
    Taint on warning
    Userspace-defined naughtiness
    System experienced a machine check exception
    Proprietary module has been loaded
  Booted kernel cmdline:
    ro root=LABEL=/ pci=nommconf rhgb quiet crashkernel=128M@16M
    enforcing=0
  GRUB default kernel line:
    vmlinuz-2.6.18-194.26.1.el5 ro root=LABEL=/ pci=nommconf rhgb quiet 
    crashkernel=128M@16M
  Kernel version/build:
    Unable to detect

CPU
  128 logical processors (64 CPU cores)
  8 Intel Xeon CPU X7560 @ 2.27GHz (flags: constant_tsc,ht,lm,pae,vmx) 
  └─16 threads / 8 cores each

MEMORY
  RAM:
    990.5g total [527.1g (53%) used]
    517.9g (52%) used excluding buffers/cache
    0.28g (0%) dirty
  HugePages:
    512.0g pre-allocated to HugePages (52% of total ram)
    0.0g of HugePages (0%) in-use by applications
  LowMem/Slab/PageTables/Shmem:
    527.1g (53%) of 990.5g LowMem in-use
    3.98g (0%) of total ram used for Slab
    0.03g (0%) of total ram used for PageTables
  Swap:
    0.0g (0%) used of 200.0g total

LSPCI
  Net:
    4 NetXen Incorporated NX3031 Multifunction 1/10-Gigabit Server Adapter (rev 42)
    └─1 quad-port NIC
    6 ServerEngines Corp. Emulex OneConnect 10Gb NIC (rev 02)
    └─3 dual-port NICs
  VGA:
    ATI Technologies Inc ES1000 (rev 02)

IP
  Interface       Slave Of  IPv4 Address        State  MAC Address
  =========       ========  ==================  =====  =================
  lo              -         127.0.0.1/8         up     -
  __tmp876605649  -         -                   DOWN   aa:bb:cc:dd:ee:ff
  __tmp471023714  -         -                   DOWN   aa:bb:cc:dd:ee:ff
  eth6            bond2     -                   up     aa:bb:cc:dd:ee:ff
  eth7            bond1     -                   up     aa:bb:cc:dd:ee:ff
  eth4            -         -                   DOWN   aa:bb:cc:dd:ee:ff
  eth9            bond1     -                   up     aa:bb:cc:dd:ee:ff
  eth0            bond0     -                   up     aa:bb:cc:dd:ee:ff
  eth1            bond0     -                   up     aa:bb:cc:dd:ee:ff
  eth2            -         -                   DOWN   aa:bb:cc:dd:ee:ff
  eth3            -         -                   DOWN   aa:bb:cc:dd:ee:ff
  bond0           -         10.0.22.36/25       up     aa:bb:cc:dd:ee:ff
  bond1           -         192.168.214.21/24   up     aa:bb:cc:dd:ee:ff
  bond2           -         10.0.29.43/26       up     aa:bb:cc:dd:ee:ff

```

The lovely thing that isn't captured here is all the coloring done to make it easier to read.


Here's the help page:

```
Usage: xsos [-xKMvabocmdleinsp] [SOSREPORT-ROOT]
  or:  xsos [--B|--C|--M|--D|--L|--I|--N|--P FILE]...
  or:  xsos [-?|-h|--help]
Extract useful data about system from SOSREPORT-ROOT or else localhost

Content options:
 -a, --all      show everything
 -b, --bios     show info from dmidecode
 -o, --os       show release, hostname, uptime, loadavg, cmdline
 -c, --cpu      show info from /proc/cpuinfo
 -m, --mem      show info from /proc/meminfo
 -d, --disks    show info from /proc/partitions + dm-multipath
 -l, --lspci    show info from lspci
 -e, --ethtool  show info from ethtool
 -i, --ip       show info from ip addr (BASH v4+ required)
 -n, --net      show info from /proc/net/dev
 -s, --sysctl   show important kernel sysctls
 -p, --ps       inspect running processes via ps

Display options:
 -x, --nocolor  disable output colorization
 -K, --kb       show /proc/meminfo in KiB
 -M, --mb       show /proc/meminfo in MiB
 -v, --verbose  show more processes & cmd args with ps

Note that xsos argument parsing is performed by GNU getopt, so order of args
is not important (e.g. the SOSREPORT-ROOT could be the 1st argument).

If no content options are specified, xsos only shows some information,
equivalent to:

  xsos --os --cpu --mem --lspci --ip
  
If SOSREPORT-ROOT isn't provided, the data will be gathered from the localhost;
however, bios, multipath, and ethtool output will only be displayed if running
as root (UID 0). When executing in this manner as non-root, those modules will
be silently skipped, even if explicitly requested.

Sometimes a full sosreport isn't available; sometimes you simply have a
dmidecode-dump or the contents of /proc/meminfo and you'd like a summary...

Special options (BASH v4+ required):
 --B=FILE  FILE must contain `dmidecode` dump
 --C=FILE  FILE must contain /proc/cpuinfo dump
 --M=FILE  FILE must contain /proc/meminfo dump
 --D=FILE  FILE must contain /proc/partitions dump
 --L=FILE  FILE must contain `lspci` dump
 --I=FILE  FILE must contain `ip addr` dump
 --N=FILE  FILE must contain /proc/net/dev dump
 --P=FILE  FILE must contain `ps aux` dump

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

The following environment variables change the behavior of xsos:
  XSOS_COLORS    XSOS_FOLD_WIDTH    XSOS_HEADING_SEPARATOR
  XSOS_ALL_VIEW  XSOS_DEFAULT_VIEW  XSOS_UPDATE_CONFIRM
  XSOS_PS_LEVEL  XSOS_MEM_UNIT
  
The following environment variables control the default colors:
  XSOS_COLOR_RESET      XSOS_COLOR_WARN1  XSOS_COLOR_WARN2
  XSOS_COLOR_IMPORTANT  XSOS_COLOR_IFUP   XSOS_COLOR_IFDOWN
  XSOS_COLOR_H1         XSOS_COLOR_H2     XSOS_COLOR_H3

See the first page or so of xsos for details.

Version info: xsos v0.0.9rc2b last mod 2012/11/12
Report bugs or suggestions to <rsaw@redhat.com>
Or see <github.com/ryran/xsos> for bug tracker & latest version
Alternatively, run xsos with '--update|-U'
```


Run on localhost with a few options:

```
[rsaw@sawzall]$ sudo xsos --ip --ethtool --net --ps
ETHTOOL
  em1         link=DOWN                        drv e1000e v2.0.0-k / fw 0.13-3
  tun0        link=UP 10Mb/s full (autoneg=N)  drv tun v1.6
  virbr0      link=DOWN                        drv bridge v2.3 / fw N/A
  virbr0-nic  link=DOWN                        drv tun v1.6
  wlan0       link=UP                          drv iwlwifi v3.5.3-1.fc17.x86_64 / fw 9.221.4.1

IP
  Interface   Slave Of  MAC Address        State  IPv4 Address
  =========   ========  =================  =====  ==================
  lo          -         -                  up     127.0.0.1/8
  em1         -         f0:de:f1:ba:cf:c4  up     -
  wlan0       -         24:77:03:41:41:18  up     10.7.7.111/24
  virbr0      -         52:54:00:97:e3:ee  up     192.168.122.1/24
  virbr0-nic  -         52:54:00:97:e3:ee  DOWN   -
  tun0        -         -                  up     10.11.10.10/32

NETDEV
  Interface   RxMBytes  RxPackets  RxErrs  RxDrop  TxMBytes  TxPackets  TxErrs  TxDrop
  =========   ========  =========  ======  ======  ========  =========  ======  ======
  em1         1110      1618247    0       0       508       1293102    0       0
  tun0        2         4681       0       0       0         4275       0       0
  virbr0      0         0          0       0       0         0          0       0
  virbr0-nic  0         0          0       0       0         0          0       0
  wlan0       456       485879     0       0       54        292131     0       0

PS CHECK
  Top users of CPU & MEM: 
    USER    %CPU   %MEM   RSS 
    rsaw    41.4%  20.9%  1.83 GiB
    root    4.7%   1.0%   0.19 GiB
    colord  0.0%   0.1%   0.01 GiB
  Uninteruptible sleep & Defunct processes: 
    USER     PID    %CPU  %MEM  VSZ      RSS      TTY    STAT  START  TIME      COMMAND  
    root     10780  0.0   0.0   11520    7824     ?      Ds    Jan19  48:05     hald 
    root     19333  0.0   0.0   55344    3568     ?      Ds    Aug23  0:00      -bash 
    root     21466  0.0   0.0   54256    1968     ?      D     Aug23  0:00      ls --color=tty /mig 
    root     22244  0.0   0.0   53376    1408     ?      D     Aug23  0:00      fuser /mig 
    root     22272  0.0   0.0   55344    3552     ?      Ds    Aug23  0:00      -bash 
    root     24110  0.0   0.0   53392    592      ?      D     Aug23  0:00      lsof /mig  
    vantage  10188  0.0   0.0   0        0        ?      Zl    Aug21  16:25     [blamFandoz] <defunct> 
  Top CPU-using processes: 
    USER     PID   %CPU  %MEM  VSZ      RSS     TTY    STAT   START  TIME   COMMAND  
    rsaw     2155  25.5  2.6   1409240  216124  ?      Sl     Nov12  39:38  /usr/lib64/chromium-browser/chromium-browser --type=plugin --plugin-path=/usr/lib64/flash-plugin/li
    rsaw     1684  6.1   3.1   1900680  254332  ?      Sl     Nov12  9:39   /usr/bin/gnome-shell 
    root     1141  4.7   0.2   118740   23048   tty1   Ss+    Nov12  7:35   /usr/bin/Xorg :0 -background 
    rsaw     2763  2.7   1.4   1172552  120704  ?      Sl     Nov12  3:38   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     1998  2.2   1.5   906376   127048  ?      Sl     Nov12  3:28   /usr/lib64/chromium-browser/chromium-browser --enable-plugins --enable-extensions 
    rsaw     1632  2.2   0.0   475128   7624    ?      S<l    Nov12  3:29   /usr/bin/pulseaudio --start 
    rsaw     4507  1.0   0.4   1150868  38848   ?      Sl     Nov12  0:58   gnome-control-center sound 
    rsaw     3295  0.6   0.4   630044   36596   ?      Sl     Nov12  0:42   gedit 
    rsaw     2093  0.4   1.9   1234676  160736  ?      Sl     Nov12  0:43   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     2714  0.3   1.6   1186756  130404  ?      Sl     Nov12  0:25   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
  Top MEM-using processes: 
    USER     PID   %CPU  %MEM  VSZ      RSS     TTY    STAT   START  TIME   COMMAND  
    rsaw     1684  6.1   3.1   1900680  254332  ?      Sl     Nov12  9:39   /usr/bin/gnome-shell 
    rsaw     2155  25.5  2.6   1409240  216124  ?      Sl     Nov12  39:38  /usr/lib64/chromium-browser/chromium-browser --type=plugin --plugin-path=/usr/lib64/flash-plugin/li
    rsaw     2093  0.4   1.9   1234676  160736  ?      Sl     Nov12  0:43   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     2714  0.3   1.6   1186756  130404  ?      Sl     Nov12  0:25   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     1998  2.2   1.5   906376   127048  ?      Sl     Nov12  3:28   /usr/lib64/chromium-browser/chromium-browser --enable-plugins --enable-extensions 
    rsaw     2763  2.7   1.4   1172552  120704  ?      Sl     Nov12  3:38   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     2048  0.0   1.0   1135500  84056   ?      Sl     Nov12  0:02   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     2057  0.2   0.9   1152032  79000   ?      Sl     Nov12  0:19   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     3075  0.0   0.8   1116228  65324   ?      Sl     Nov12  0:03   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     2065  0.0   0.7   1110356  58524   ?      Sl     Nov12  0:00   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 

```



Run on another sosreport with some options:

```
[rsaw@sawzall]$ xsos 8308201prodserv --disks --mem --mb
MEMORY
  RAM:
    64363m total [61815m (96.0%) used]
    49451m (76.8%) used excluding buffers/cache
    5m (0.0%) dirty
  HugePages:
    38912m pre-allocated to HugePages (60.5% of total ram)
    38146m of HugePages (98.0%) in-use by applications
  LowMem/Slab/PageTables/Shmem:
    61815m (96.0%) of 64363m LowMem in-use
    1192m (1.9%) of total ram used for Slab
    349m (0.5%) of total ram used for PageTables
  Swap:
    464m (2.8%) used of 16381m total

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

```



Run on a sosreport again, showing sysctls:

```
[rsaw@sawzall]$ xsos --sysctl aczx998pinkle/
SYSCTLS
  kernel.
    osrelease: 2.6.18-194.26.1.el5
    tainted: 536870912 512 64 16 1
      Technology Preview code is loaded
      Taint on warning
      Userspace-defined naughtiness
      System experienced a machine check exception
      Proprietary module has been loaded
    random.boot_id: d0c940ea-77df-4167-919d-XXXXXXXXXXX
    random.entropy_avail: 2006
    panic: 0 (seconds til reboot after panic)
    hung_task_panic: 0
    panic_on_oops: 1
    panic_on_unrecovered_nmi: 0
    sysrq: 1
    sem: 10000 100000 1000 1000
      max semaphores per array = 10000
      max sems system-wide     = 100000
      max ops per semop call   = 1000
      max number of arrays     = 1000
    shmall (pages): 4294967296 (16384.0 G max total shared memory)
    shmmax (bytes): 137438953471 (128.00 G max segment size)
    shmmni (segments): 4096 (max number of segs)
  vm.
    dirty_ratio: 40 %
    dirty_background_ratio: 10 %
    dirty_bytes:  b
    dirty_background_bytes:  b
    dirty_expire_centisecs: 2999
    dirty_writeback_centisecs: 499
    nr_hugepages: 262144 pages
    overcommit_memory: 0
    overcommit_ratio: 50 %
    panic_on_oom: 0
  net.
    ipv4.icmp_echo_ignore_all: 0
    ipv4.ip_forward: 0
    ipv4.tcp_max_orphans (sockets): 65536 (4096 M @ max 64 K per orphan)
    ipv4.tcp_mem (pages): 196608 262144 393216 (0.75 G, 1.00 G, 1.50 G)
    ipv4.udp_mem (pages): 97537152 130049536 195074304 (372.07 G, 496.10 G, 744.15 G)
    ipv4.tcp_rmem (bytes): 4096 87380 4194304 (4 K, 85 K, 4096 K)
    ipv4.tcp_wmem (bytes): 4096 16384 4194304 (4 K, 16 K, 4096 K)
    ipv4.udp_rmem_min (bytes): 4096 (4 K)
    ipv4.udp_wmem_min (bytes): 4096 (4 K)

```


Finally, here's example of using some of the Special options, which allow you to specify a specific file instead of a full sosreport or having `xsos` run on your local system:

```
[rsaw@sawzall]$ XSOS_PS_VERBOSE=0 xsos --B /tmp/dmidecode.txt --I=/tmp/ipaddr.dump --P /tmp/psaux.txt
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

PS CHECK
  Top users of CPU & MEM: 
    USER     %CPU    %MEM      RSS 
    oracle   909.4%  60648.5%  38137.05 GiB
    root     5.4%    0.0%      0.05 GiB
    bimpy    0.0%    0.0%      0.00 GiB
  Uninteruptible sleep & Defunct processes: 
    USER     PID    %CPU  %MEM  VSZ     RSS       TTY    STAT  START  TIME      COMMAND  
    oracle   7883   0.3   59.3  144844  39092824  ?      Ds    Jul31  2:33      oracleCRELSP4 
    oracle   11028  0.1   59.3  157576  39085972  ?      Ds    Jun30  49:08     ora_arc8_CRELSP4 
    oracle   13816  0.0   59.3  143820  39087180  ?      Ds    Jul31  0:12      oracleCRELSP4 
    oracle   15184  0.4   59.3  144828  39092536  ?      Ds    Jul31  3:01      oracleCRELSP4 
    oracle   15423  0.5   59.3  146888  39095284  ?      Ds    Jul31  3:32      oracleCRELSP4 
  Top CPU-using processes: 
    USER     PID    %CPU  %MEM  VSZ     RSS       TTY    STAT  START  TIME      COMMAND  
    oracle   11160  19.7  59.3  149032  39090544  ?      Ss    Jun30  9012:36   oracleCRELSP4 
    oracle   14014  10.6  59.3  143460  39089120  ?      Ss    10:32  0:05      oracleCRELSP4 
    root     6515   5.3   0.0   0       0         ?      R     Jan14  15483:17  [rpciod] 
    oracle   19944  5.1   59.2  141404  39083068  ?      Ss    10:20  0:40      oracleCRELSP4 
    oracle   24559  4.1   59.3  144824  39091032  ?      Ss    10:22  0:27      oracleCRELSP4 
  Top MEM-using processes: 
    USER     PID    %CPU  %MEM  VSZ     RSS       TTY    STAT  START  TIME      COMMAND  
    oracle   7847   0.0   59.4  255316  39175576  ?      Ss    Jun30  0:52      ora_diag_CRELSP4 
    oracle   9976   0.7   59.3  144828  39092412  ?      Ss    Jul31  5:22      oracleCRELSP4 
    oracle   9969   0.8   59.3  144844  39092488  ?      Ss    Jul31  6:05      oracleCRELSP4 
    oracle   9962   0.8   59.3  146876  39095472  ?      Ss    Jul31  6:32      oracleCRELSP4 
    oracle   9958   0.6   59.3  146876  39094276  ?      Ss    Jul31  4:31      oracleCRELSP4 

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
* When printing disk info with `-d/--disks`, `xsos` automatically detects linux software raid (md) devices and hides their components. The `multipath` command is also consulted to print info about native multipathd devices. All LUNS that are part of a dm-multipath map are also hidden from the disk output.
* There are a bunch of environment variables that you can use to tweak behavior. See [the original commit comment](/ryran/xsos/commit/0c05168d3729d44f4ddf07269b33105f85a306de#commitcomment-2133859) for documentation.
* When printing info on pci net devices (`-l/--lspci`), `xsos` simplifies the net output in an intelligent way. Example:

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
    2 Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12)
    └─2 single-port NICs
    4 Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
    └─2 dual-port NICs
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

