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

Simply download [this one file](https://raw.github.com/ryran/xsos/master/xsos) and save it to a directory that's in your `PATH`. Make it executable and you'll be good to go!  

**Example:**

```
$ su -
# wget -O /usr/local/bin/xsos http://bit.ly/xsos-direct
# chmod +x /usr/local/bin/xsos
# exit
$ xsos -h
```

**Jump to ...**

* [INSTALLATION](/ryran/xsos#installation)
* [EXAMPLES IN ACTION](/ryran/xsos#examples-in-action)
* [REQUIREMENTS](/ryran/xsos#requirements)
* [THINGS THAT MIGHT SURPRISE YOU](/ryran/xsos#things-that-might-surprise-you)
* [AUTHORS](/ryran/xsos#authors)
* [LICENSE](/ryran/xsos#license)


EXAMPLES IN ACTION
-------
The lovely thing that isn't going to be captured here is all the coloring done to make things easier to read. There's actually quite a bit of color-logic to warn of various conditions...

**Run on a sosreport with no options:**

```
[rsaw]$ xsos aczx998pinkle/
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
    990.5 GiB total [527.1 GiB (53%) used]
    517.9 GiB (52%) used excluding buffers/cache
    0.28 GiB (0%) dirty
  HugePages:
    512.0 GiB pre-allocated to HugePages (52% of total ram)
    0.0 GiB of HugePages (0%) in-use by applications
  LowMem/Slab/PageTables/Shmem:
    527.1 GiB (53%) of 990.5 GiB LowMem in-use
    3.98 GiB (0%) of total ram used for Slab
    0.03 GiB (0%) of total ram used for PageTables
  Swap:
    0.0 GiB (0%) used of 200.0 GiB total

LSPCI
  Net/Storage:
    1 quad-port (4) NetXen Incorporated NX3031 Multifunction 1/10-Gigabit Server Adapter (rev 42)
    6 dual-port (12) QLogic Corp. ISP2532-based 8Gb Fibre Channel to PCI Express HBA (rev 02)
    3 dual-port (6) ServerEngines Corp. Emulex OneConnect 10Gb NIC (rev 02)
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


**While xsos is always changing, here's the minimal help page from v0.0.9rc7:**

```
[rsaw]$ xsos -h
Usage: xsos [-xKMG] [-w N] [-v N] [-abocmdleinsp] [SOSREPORT-ROOT]
  or:  xsos [--B|--C|--M|--D|--L|--I|--N|--P FILE]...
  or:  xsos [-?|-h|--help]
  or:  xsos [-U|--update]
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
 -x, --nocolor    disable output colorization
 -K, --kb         show /proc/meminfo & /proc/net/dev in KiB
 -M, --mb         show /proc/meminfo & /proc/net/dev in MiB
 -G, --gb         show /proc/meminfo & /proc/net/dev in GiB
 -w, --width=N    change fold-width (76-char default; 0 autodetects)
 -v, --verbose=N  specify ps verbosity level (0-4, defaults to 1)

Special options (BASH v4+ required):
 --B=FILE  read from FILE containing `dmidecode` dump
 --C=FILE  read from FILE containing /proc/cpuinfo dump
 --M=FILE  read from FILE containing /proc/meminfo dump
 --D=FILE  read from FILE containing /proc/partitions dump
 --L=FILE  read from FILE containing `lspci` dump
 --I=FILE  read from FILE containing `ip addr` dump
 --N=FILE  read from FILE containing /proc/net/dev dump
 --P=FILE  read from FILE containing `ps aux` dump

Run with '--help' to see full help page

Version info: xsos v0.0.9rc7 last mod 2012/12/02
See <github.com/ryran/xsos> to report bugs or suggestions
```


**Run on my laptop as root, with a few options:**

```
[rsaw]$ sudo xsos --ip --lspci --ethtool --net --ps
LSPCI
  Net/Storage:
    (1) Intel Corporation Centrino Ultimate-N 6300 (rev 3e)
    (1) Intel Corporation 82579LM Gigabit Network Connection (rev 04)
  VGA:
    Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09)

ETHTOOL
  em1         link=DOWN                        drv e1000e v2.0.0-k / fw 0.13-3
  tun0        link=UP 10Mb/s full (autoneg=N)  drv tun v1.6
  virbr0      link=DOWN                        drv bridge v2.3 / fw N/A
  virbr0-nic  link=DOWN                        drv tun v1.6
  wlan0       link=UP                          drv iwlwifi v3.5.3-1.fc17.x86_64 / fw 9.221.4.1

IP
  Interface   Slave Of  IPv4 Address        State  MAC Address
  =========   ========  ==================  =====  =================
  lo          -         127.0.0.1/8         up     -
  em1         -         -                   up     f0:de:f1:ba:cf:c4
  wlan0       -         10.7.7.111/24       up     24:77:03:41:41:18
                        192.168.17.17/32            
  virbr0      -         192.168.122.1/24    up     52:54:00:97:e3:ee
  virbr0-nic  -         -                   DOWN   52:54:00:97:e3:ee
  tun0        -         10.11.11.249/32     up     -


NETDEV
  Interface   RxMiBytes  RxPackets  RxErrs  RxDrop  TxMiBytes  TxPackets  TxErrs  TxDrop
  =========   =========  =========  ======  ======  =========  =========  ======  ======
  em1         3211.9     4389k      0       0       5073.6     5120k      0       0
  virbr0      4.4        40k        0       0       244.1      42k        0       0
  virbr0-nic  0.0        0k         0       0       0.0        0k         0       0
  wlan0       4172.2     3964k      0       0       310.4      2198k      0       0

PS CHECK
  Top users of CPU & MEM: 
    USER    %CPU   %MEM   RSS 
    qemu    78.6%  6.6%   0.51 GiB
    rsaw    53.7%  61.2%  4.99 GiB
    root    4.6%   1.8%   0.25 GiB
    colord  0.0%   0.0%   0.01 GiB
  Uninteruptible sleep & Defunct processes: 
    USER     PID    %CPU  %MEM  VSZ      RSS      TTY     STAT   START  TIME    COMMAND   
    root     10780  0.0   0.0   11520    7824     ?       Ds     Jan19  48:05   hald 
    root     19333  0.0   0.0   55344    3568     ?       Ds     Aug23  0:00    -bash 
    root     21466  0.0   0.0   54256    1968     ?       D      Aug23  0:00    ls --color=tty /mig 
    root     22244  0.0   0.0   53376    1408     ?       D      Aug23  0:00    fuser /mig 
    root     22272  0.0   0.0   55344    3552     ?       Ds     Aug23  0:00    -bash 
    root     24110  0.0   0.0   53392    592      ?       D      Aug23  0:00    lsof /mig  
    rsaw     21860  0.0   0.0   0        0        ?       Z      Nov29  0:06    [xchat] <defunct> 
    rsaw     22586  0.0   0.0   0        0        ?       Z      Nov28  2:21    [vlc] <defunct> 
    rsaw     26748  0.0   0.0   0        0        ?       Z      Nov29  3:56    [chromium-browse] <defunct> 
    rsaw     30294  3.1   0.0   0        0        ?       Z      Nov28  220:22  [thunderbird] <defunct> 
  Top CPU-using processes: 
    USER     PID    %CPU  %MEM  VSZ      RSS      TTY     STAT   START  TIME    COMMAND  
    qemu     22984  78.6  6.6   3892588  533828   ?       Sl     21:12  0:40    /usr/bin/qemu-kvm -S -M 
    rsaw     18091  10.3  5.7   1903624  461488   ?       Sl     Dec01  267:41  /usr/lib64/chromium-browser/chromium-browser --type=plugin --plugin-path=/usr/lib64/flash-plugin/
    rsaw     7832   10.0  1.4   1213988  114412   ?       Sl     16:37  27:48   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     22939  7.2   1.9   1085452  158076   ?       Ss     21:12  0:04    python /usr/share/virt-manager/virt-manager.py 
    rsaw     21741  5.4   1.0   1147760  82308    ?       Sl     20:41  1:41    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     2180   5.0   22.3  3433136  1797084  ?       Sl     Nov26  468:29  /usr/lib64/firefox/firefox 
    rsaw     22303  3.6   6.6   1944612  532380   ?       Sl     Dec01  63:27   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     6869   3.3   2.4   1288596  198824   ?       Sl     16:12  9:55    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     30294  3.1   0.0   0        0        ?       Z      Nov28  220:22  [thunderbird] <defunct> 
    rsaw     1872   2.3   4.8   2210792  394716   ?       Rl     Nov26  216:37  /usr/bin/gnome-shell 
  Top MEM-using processes: 
    USER     PID    %CPU  %MEM  VSZ      RSS      TTY     STAT   START  TIME    COMMAND  
    rsaw     2180   5.0   22.3  3433136  1797084  ?       Sl     Nov26  468:29  /usr/lib64/firefox/firefox 
    rsaw     22303  3.6   6.6   1944612  532380   ?       Sl     Dec01  63:27   /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    qemu     22984  78.6  6.6   3892588  533828   ?       Sl     21:12  0:40    /usr/bin/qemu-kvm -S -M 
    rsaw     18091  10.3  5.7   1903624  461488   ?       Sl     Dec01  267:41  /usr/lib64/chromium-browser/chromium-browser --type=plugin --plugin-path=/usr/lib64/flash-plugin/
    rsaw     1872   2.3   4.8   2210792  394716   ?       Rl     Nov26  216:37  /usr/bin/gnome-shell 
    rsaw     6869   3.3   2.4   1288596  198824   ?       Sl     16:12  9:55    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     18254  0.1   2.4   1300592  196492   ?       Sl     Dec01  4:42    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
    rsaw     22939  7.2   1.9   1085452  158076   ?       Ss     21:12  0:04    python /usr/share/virt-manager/virt-manager.py 
    rsaw     17910  0.9   1.9   986252   155516   ?       Sl     Dec01  24:58   /usr/lib64/chromium-browser/chromium-browser --enable-plugins --enable-extensions 
    rsaw     19196  0.1   1.8   1217468  146336   ?       Sl     Dec01  2:31    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US 
```



**Run on another sosreport with some options:**

```
[rsaw]$ xsos 8308201prodserv --disks --mem --mb
MEMORY
  RAM:
    64363 MiB total [61815 MiB (96.0%) used]
    49451 MiB (76.8%) used excluding buffers/cache
    5 MiB (0.0%) dirty
  HugePages:
    38912 MiB pre-allocated to HugePages (60.5% of total ram)
    38146 MiB of HugePages (98.0%) in-use by applications
  LowMem/Slab/PageTables/Shmem:
    61815 MiB (96.0%) of 64363 MiB LowMem in-use
    1192 MiB (1.9%) of total ram used for Slab
    349 MiB (0.5%) of total ram used for PageTables
  Swap:
    464 MiB (2.8%) used of 16381 MiB total

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

[rsaw]$ xsos --net --kb 8308201prodserv
NETDEV
  Interface  RxKiBytes     RxPackets     RxErrs  RxDrop  TxKiBytes     TxPackets     TxErrs  TxDrop
  =========  =========     =========     ======  ======  =========     =========     ======  ======
  eth0       23569277      300080406     0       0       587500973     480926218     0       0
  eth1       144484269105  342207919183  0       4494    259888863511  357978804158  0       0
  eth2       428438229206  392560553366  0       373     122422250847  330736051661  0       0
  eth4       37184228554   55232280858   0       2350    23097311644   35535848225   0       0

[rsaw]$ xsos -nG 8308201prodserv
NETDEV
  Interface  RxGiBytes  RxPackets  RxErrs  RxDrop  TxGiBytes  TxPackets  TxErrs  TxDrop
  =========  =========  =========  ======  ======  =========  =========  ======  ======
  eth0       22.48      300.1M     0       0       560.28     480.9M     0       0
  eth1       137790.94  342207.9M  0       4494    247849.33  357978.8M  0       0
  eth2       408590.54  392560.6M  0       373     116750.96  330736.1M  0       0
  eth4       35461.64   55232.3M   0       2350    22027.31   35535.8M   0       0
```



**Run on a sosreport again, showing sysctls:**

```
[rsaw]$ xsos --sysctl aczx998pinkle/
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


**Finally, here's example of using some of the Special options, which allow you to specify a specific file instead of a full sosreport or having `xsos` run on your local system:**

```
[rsaw]$ xsos -v0 --B /tmp/dmidecode.txt --I=/tmp/ipaddr.dump --P /tmp/psaux.txt
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
* When running on localhost (i.e. not a sosreport), `xsos` gracefully reports as much of what's requested as possible when running as non-root (`--bios` and `--ethtool` require root privileges; `--disks` won't be able to print dm-multipath output without root privs).


THINGS THAT MIGHT SURPRISE YOU
-------

* `xsos` does some pretty intensive color-formatting to make the output more easily-readable (can be disabled with `-x` or `--nocolor`).
  * If you like the color but need to use a pager, pipe to `more` or `less -R`
  * There are multiple environment variables for managing the colors. You don't need to modify the script itself. See [the original commit comment](/ryran/xsos/commit/0c05168d3729d44f4ddf07269b33105f85a306de#commitcomment-2133859) for documentation.
* `xsos` can update itself via the internet in 10 seconds if run with `--update` or `-U`.
  * Set environment variable `XSOS_UPDATE_CONFIRM` to "`n`" if you don't want `--update` to prompt for confirmation.
* When printing disk info with `-d/--disks`, `xsos` automatically detects linux software raid (md) devices and hides their components. The `multipath` command is also consulted to print info about native multipathd devices. All LUNs that are part of a dm-multipath map are also hidden from the disk output.
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
  Net/Storage:
    2 single-port (2) Broadcom Corporation NetXtreme II BCM5708 Gigabit Ethernet (rev 12)
    2 dual-port (4) Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
  Graphics:
    Advanced Micro Devices [AMD] nee ATI ES1000 (rev 02)
```


AUTHORS
-------

As far as direct contributions go, so far it's just me, [ryran](/ryran), aka rsaw, aka [Ryan Sawhill](http://b19.org).

When I was clueless in how to further my awk career early on, two prolific users over on StackOverflow -- [Dennis Williamson](http://stackoverflow.com/users/26428/dennis-williamson) and [ghostdog74](http://stackoverflow.com/users/131527/ghostdog74) -- each provided an answer with code that was brilliantly instructive. I've since moved far beyond what I was trying to do back then, and thanks definitely goes to both of them for inspiration.

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

