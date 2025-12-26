xsos - Summarize system info from sosreports
===================================================

**Jump to ...**

* [I'M LOOKING FOR RSAR](https://github.com/ryran/rsar)
* [SCREEN SHOTS](#screen-shots)
* [INTRO](#intro)
* [INSTALLATION](#installation)
* [EXAMPLES IN ACTION](#examples-in-action)
* [REQUIREMENTS](#requirements)
* [THINGS THAT MIGHT SURPRISE YOU](#things-that-might-surprise-you)
* [AUTHORS](#authors)
* [LICENSE](#license)


SCREEN SHOTS
-------

**`xsos -om` OR `xsos --os --mem` would show something like the following:**

![xsos parsing general os info and /proc/meminfo](http://b19.org/linux/xsos-osmem.png)

**`xsos -cln` OR `xsos --cpu --lspci --net` could show this:**

![xsos parsing /proc/cpuinfo, lspci, /proc/net/dev](http://b19.org/linux/xsos-cln.png)

**`xsos -e` OR `xsos --ethtool` output looks like this:**

![xsos parsing ethtool output](http://b19.org/linux/xsos-e.png)


INTRO
-------

The goal of `xsos` is to make it easy to instantaneously gather information about a system together in an easy-to-read-summary, whether that system is the localhost on which xsos is being run or a system for which you have an unpacked sosreport.

There is tons of useful amazing instructive data available to normal users (not to mention root) on a Linux system, but by design, this information is spread out across myriad files. Some of it even requires commands to parse through.

`xsos` will attempt to make it easy, parsing and calculating and formatting data from dozens of files (and commands) to give you a detailed overview about a system, or -- if requested -- `xsos` will only parse one file (e.g. with `--mem` or `--cpu`) or output from one command (e.g. with `--ip` or `--ps`).

New features are being added all the time -- see [the tracker](https://github.com/ryran/xsos/issues) to have a look at some of the things that are already in line to be worked on.

**[Why another tool? Why not add stuff to `sxconsole`?](https://github.com/ryran/xsos/issues/9)**


INSTALLATION
-------

*"I'm sold! How do I install xsos?"*

Get the latest version directly by downloading the main xsos file from [bit.ly/xsos-direct](http://bit.ly/xsos-direct) (which points to [raw.github.com/ryran/xsos/master/xsos](https://raw.github.com/ryran/xsos/master/xsos)). Updating will need to be done manually by re-downloading.

For a personal non-root install, run the following as your normal user:

```
mkdir -p ~/bin/
curl -Lo ~/bin/xsos bit.ly/xsos-direct
```

Then open a new terminal (your `~/.profile` should add `~/bin/` into `%PATH`).

For a system-wide install, run the following as root:
   
```
curl -Lo /usr/local/bin/xsos bit.ly/xsos-direct
chmod +x /usr/local/bin/xsos
```

Once xsos is installed, run `xsos -h` as a normal user to see the help page and get started.

EXAMPLES IN ACTION
-------
The lovely thing that isn't going to be captured here is all the coloring done to make things easier to read. There's actually quite a bit of color-logic to warn of various conditions...

**Run on a sosreport with no options:**

```
[rsaw]$ xsos aczx998pinkle/
OS
  Hostname: aczx998pinkle
  Distro:   [redhat-release] Red Hat Enterprise Linux Server release 5.5 (Carthage)
            [enterprise-release] Enterprise Linux Enterprise Linux Server release 5.5 (Carthage)
  RHN:      serverURL=https://linux-update.oracle.com/XMLRPC
  Runlevel: N 3  (default 3)
  SELinux:  permissive  (default enforcing)
  Arch:     mach=x86_64  cpu=x86_64  platform=x86_64
  Kernel:
    Booted kernel:  2.6.18-238.12.2.0.2.el5
    GRUB default:   2.6.18-238.12.2.0.2.el5
    Build version:
      Linux version 2.6.18-238.12.2.0.2.el5 (mockbuild@ca-build9.us.oracle.com) (gcc version 4.1.2
      20080704 (Red Hat 4.1.2-50)) #1 SMP Tue Jun 28 05:21:19 EDT 2011
    Booted kernel cmdline:
      root=/dev/md6 ro bootarea=c0d0 loglevel=7 panic=60 debug rhgb numa=off console=ttyS0,115200n8
      console=tty1 crashkernel=128M@16M bootfrom=CELLBOOT audit=1 processor.max_cstate=1 nomce
    GRUB default kernel cmdline:
      root=/dev/md6 ro bootarea=c0d0 loglevel=7 panic=60 debug rhgb numa=off console=ttyS0,115200n8
      console=tty1 crashkernel=128M@16M bootfrom=BOOT audit=1 processor.max_cstate=1 nomce
    Kernel taint-check: 536870912 512 64 16 1
      Technology Preview code is loaded
      Taint on warning
      Userspace-defined naughtiness
      System experienced a machine check exception
      Proprietary module has been loaded
    - - - - - - - - - - - - - - - - - - -
  Sys time:  Mon Oct 29 10:55:02 CDT 2012
  Boot time: Sat Apr 28 03:29:56 CDT 2012  (1335583796)
  Uptime:    184 days, 12:25,  1 user
  LoadAvg:   [24 CPU] 2.34 (10%), 1.27 (5%), 0.95 (4%)
  /proc/stat:
    procs_running: 4    procs_blocked: 1    processes: 248052571
    cpu:  [Break-down of CPU time since boot]
      us 1%, ni 0%, sys 1%, idle 96%, iowait 2%, irq 0%, sftirq 0%, steal 0%
```


**While xsos is always being improved, here's the current minimal help page (run `xsos -h`):**

```
Usage: xsos [DISPLAY OPTIONS] [-6abokcfmdtlerngispSFIN] [SOSREPORT ROOT]
  or:  xsos [DISPLAY OPTIONS] {--B|--C|--F|--M|--D|--T|--L|--R|--N|--G|--I|--P FILE}...
  or:  xsos [-?|-h|--help]

Display system info from localhost or extracted sosreport

Content options:
 -a, --all       show everything
 -b, --bios      show info from dmidecode
 -o, --os        show hostname, distro, SELinux, kernel info, uptime, etc
 -k, --kdump     inspect kdump configuration
 -c, --cpu       show info from /proc/cpuinfo
 -f, --intrupt   show info from /proc/interrupts
 -m, --mem       show info from /proc/meminfo
 -d, --disks     show info from /proc/partitions, dm-multipath, lsblk, df
 -t, --mpath     show info from dm-multipath
 -l, --lspci     show info from lspci
 -e, --ethtool   show info from ethtool
 -r, --softirq   show info from /proc/net/softnet_stat
 -n, --netdev    show info from /proc/net/dev
 -g, --bonding   show bonding and teaming info
 -i, --ip        show info from ip addr (BASH v4+ required)
     --net       alias for: --lspci --ethtool --softirq --netdev --bonding --ip
 -s, --sysctl    show important kernel sysctls
 -p, --ps        inspect running processes via ps
 -S, --ss        inspect running processes via ss
 -F, --firewall  show firewall status
 -I, --ifcfg     show ifcfg files summary
 -N, --netstat   show info from /proc/net/netstat

Display options:
     --scrub        remove from output: IP/MAC addrs, hostnames, serial numbers,
                    proxy user & passwords
 -6, --ipv6         parse ip addr output for IPv6 addresses instead of IPv4
 -q, --wwid=ID      restrict dm-multipath output to a particular mpath device,
                    where ID is a wwid, friendly name, or LUN identifier
 -u, --unit=P       change byte display for /proc/meminfo & /proc/net/dev,
                    where P is "b" for byte, or else "k", "m", "g", or "t"
     --threads      make ps take threads into account (via `ps auxm`)
 -v, --verbose=NUM  specify ps verbosity level (0-4, default: 1)
 -w, --width=NUM    change fold-width, in columns (positive number, e.g., 80)
                    "0" disables wrapping, "w" autodetects width (default)
 -x, --nocolor      disable output colorization
 -y, --less         send output to `less -SR`
 -z, --more         send output to `more`

Special options (BASH v4+ required):
 --B=FILE  read from FILE containing `dmidecode` dump
 --C=FILE  read from FILE containing /proc/cpuinfo dump
 --F=FILE  read from FILE containing /proc/interrupts dump
 --M=FILE  read from FILE containing /proc/meminfo dump
 --D=FILE  read from FILE containing /proc/partitions dump
 --T=FILE  read from FILE containing `multipath -v4 -ll` dump
 --L=FILE  read from FILE containing `lspci` dump
 --R=FILE  read from FILE containing /proc/net/softnet_stat dump
 --N=FILE  read from FILE containing /proc/net/dev dump
 --G=FILE  read from FILE containing /proc/net/bonding/xxx dump
 --I=FILE  read from FILE containing `ip addr` dump
 --P=FILE  read from FILE containing `ps aux` dump

Run with "--help" to see full help page

Version info: xsos v0.7.40 last mod 2025-12-01
See <github.com/ryran/xsos> to report bugs or suggestions
```


**Here it is run on my laptop as root, with specific options:**

```
[rsaw]$ sudo xsos --bios --ip --lspci --ethtool --net --ps  # would be same as 'xsos -bilenp'
DMIDECODE
  BIOS:
    LENOVO, version 8CET50WW (1.30 ), 11/01/2011
  System:
    Mfr:  LENOVO
    Prod: 4174AQ5
    Vers: ThinkPad T420s
    Ser:  R9XXXXXXXX
    UUID: 56EABD01-XXXX-11CB-9DE6-XXXXXXXXXX
  CPU:
    1 of 1 CPU sockets populated, 2 cores/4 threads per CPU
    2 total cores, 4 total threads
    Mfr:  Intel(R) Corporation
    Fam:  Core i5
    Freq: 2600 MHz
    Vers: Intel(R) Core(TM) i5-2540M CPU @ 2.60GHz
  Memory:
    8192 MB (8 GB) total
    2 of 4 DIMMs populated (system max capacity 16 GB)

LSPCI
  Net/Storage:
    (1) Intel Corporation Centrino Ultimate-N 6300 (rev 3e)
    (1) Intel Corporation 82579LM Gigabit Network Connection (rev 04)
  VGA:
    Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller (rev 09)

ETHTOOL
  Interface Status:
    em1         link=up 1000Mb/s full (autoneg=Y)  drv e1000e v2.2.14-k / fw 0.13-3
    tun0        link=up 10Mb/s full (autoneg=N)    drv tun v1.6
    virbr0      link=DOWN                          drv bridge v2.3 / fw N/A
    virbr0-nic  link=DOWN                          drv tun v1.6
    wlan0       link=up                            drv iwlwifi v3.9.6-200.fc18.x86_64 / fw 9.221.4.1
  Interface Errors:
    em1  dropped_smbus: 267


IP
  Interface   Slave Of  IPv4 Address        State  MAC Address
  =========   ========  ==================  =====  =================
  lo          -         127.0.0.1/8         up     -
  em1         -         192.168.0.20/24     up     f0:de:f1:ba:cf:c4
  wlan0       -         10.7.7.111/24       up     24:77:03:41:41:18
                        192.168.17.17/32
  virbr0      -         192.168.122.1/24    up     52:54:00:97:e3:ee
  virbr0-nic  -         -                   DOWN   52:54:00:97:e3:ee
  tun0        -         10.10.49.81/32      up     -

NETDEV
  Interface   RxMiBytes  RxPackets  RxErrs  RxDrop  TxMiBytes  TxPackets  TxErrs  TxDrop  TxColls
  =========   =========  =========  ======  ======  =========  =========  ======  ======  =======
  em1         6715       6940 k     0       0       6715       1972 k     0       0       0
  tun0        0          0 k        0       0       0          0 k        0       0       0
  virbr0      8          41 k       0       0       8          37 k       0       0       0
  virbr0-nic  0          0 k        0       0       0          0 k        0       0       0
  wlan0       1902       1761 k     0       0       1902       1139 k     0       0       0


PS CHECK
  Total number of processes:
    291
  Top users of CPU & MEM:
    USER  %CPU   %MEM   RSS
    rsaw  34.1%  46.0%  3.81 GiB
    qemu  27.4%  4.9%   0.38 GiB
    root  2.7%   1.0%   0.20 GiB
  Uninteruptible sleep & Defunct processes:
    USER     PID    %CPU  %MEM  VSZ-MiB  RSS-MiB  TTY    STAT   START  TIME    COMMAND
    rsaw     5287   0.0   0.0   0        0        pts/0  D+     17:19  0:00    [cat]
    rsaw     5125   0.0   0.0   0        0        ?      Z      Dec16  0:48    [chromium-browse] <defunct>
    rsaw     8307   0.2   0.0   0        0        ?      Z      Dec17  3:07    [chromium-browse] <defunct>
    rsaw     8867   0.0   0.0   0        0        ?      Z      Dec17  1:20    [xchat] <defunct>
    rsaw     9533   0.0   0.0   0        0        ?      Z      Dec17  0:32    [gedit] <defunct>
  Top CPU-using processes:
    USER     PID    %CPU  %MEM  VSZ-MiB  RSS-MiB  TTY    STAT   START  TIME    COMMAND
    qemu     613    27.4  4.9   3094     393      ?      Sl     00:38  0:29    /usr/bin/qemu-kvm -S -M
    rsaw     23059  13.7  2.3   1091     185      ?      Sl     Dec26  21:34   /proc/self/exe --type=plugin --plugin-path=/usr/lib64/flash-plugin/libflashplayer.so
    rsaw     621    5.9   0.8   964      65       ?      Ss     00:38  0:06    python /usr/share/virt-manager/virt-manager.py
    rsaw     2137   5.3   18.7  2705     1472     ?      Sl     Dec24  204:37  /usr/lib64/firefox/firefox
    root     1226   2.2   0.5   135      42       tty1   Ss+    Dec24  87:57   /usr/bin/Xorg :0 -background
    rsaw     11901  2.1   4.2   2319     335      ?      SLl    Dec24  74:54   /usr/bin/gnome-shell
    rsaw     22866  2.0   1.6   898      128      ?      Sl     Dec26  3:11    /usr/lib64/chromium-browser/chromium-browser --enable-plugins --enable-extensions
    rsaw     29408  1.3   0.5   1218     39       ?      Sl     Dec26  0:37    gedit
    rsaw     23084  0.8   1.2   1140     99       ?      Sl     Dec26  1:18    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
    rsaw     22952  0.8   1.7   1168     141      ?      Sl     Dec26  1:22    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
  Top MEM-using processes:
    USER     PID    %CPU  %MEM  VSZ-MiB  RSS-MiB  TTY    STAT   START  TIME    COMMAND
    rsaw     2137   5.3   18.7  2705     1472     ?      Sl     Dec24  204:37  /usr/lib64/firefox/firefox
    qemu     613    27.4  4.9   3094     393      ?      Sl     00:38  0:29    /usr/bin/qemu-kvm -S -M
    rsaw     11901  2.1   4.2   2319     335      ?      SLl    Dec24  74:54   /usr/bin/gnome-shell
    rsaw     23059  13.7  2.3   1091     185      ?      Sl     Dec26  21:34   /proc/self/exe --type=plugin --plugin-path=/usr/lib64/flash-plugin/libflashplayer.so
    rsaw     22952  0.8   1.7   1168     141      ?      Sl     Dec26  1:22    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
    rsaw     22866  2.0   1.6   898      128      ?      Sl     Dec26  3:11    /usr/lib64/chromium-browser/chromium-browser --enable-plugins --enable-extensions
    rsaw     23214  0.6   1.5   1141     121      ?      Sl     Dec26  0:59    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
    rsaw     23004  0.0   1.2   1130     100      ?      Sl     Dec26  0:06    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
    rsaw     22959  0.0   1.2   1127     100      ?      Sl     Dec26  0:05    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
    rsaw     23084  0.8   1.2   1140     99       ?      Sl     Dec26  1:18    /usr/lib64/chromium-browser/chromium-browser --type=renderer --lang=en-US
```



**Run on another sosreport with some options:**

```
[rsaw]$ xsos 8308201prodserv --disks --mem --unit=m
MEMORY
  Stats graphed as percent of MemTotal:
    MemUsed    ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◇◇  96.0%
    HugePages  ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇  60.5%
    Buffers    ◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇   0.6%
    Cached     ◆◆◆◆◆◆◆◆◆◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇  18.6%
    Dirty      ◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇   0.0%
  RAM:
    64363 MiB total ram
    61815 MiB (96%) used
    49451 MiB (76.8%) used excluding Buffers/Cached
    5 MiB (0%) dirty
  HugePages:
    38912 MiB pre-allocated to HugePages (60.5% of total ram)
    38146 MiB of HugePages (98%) in-use by applications
  LowMem/Slab/PageTables/Shmem:
    61815 MiB (96%) of 64363 MiB LowMem in-use
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

[rsaw]$ xsos --net --unit k 8308201prodserv
NETDEV
  Interface  RxKiBytes     RxPackets     RxErrs  RxDrop     TxKiBytes     TxPackets     TxErrs  TxDrop
  =========  =========     =========     ======  ======     =========     =========     ======  ======
  eth0       23569277      300080406     0       0          23569277      480926218     0       0
  eth1       144484269105  342207919183  0       4494 (0%)  144484269105  357978804158  0       0
  eth2       428438229206  392560553366  0       373 (0%)   428438229206  330736051661  0       0
  eth4       37184228554   55232280858   0       2350 (0%)  37184228554   35535848225   0       0


[rsaw]$ xsos -nug 8308201prodserv
NETDEV
  Interface  RxGiBytes  RxPackets  RxErrs  RxDrop     TxGiBytes  TxPackets  TxErrs  TxDrop
  =========  =========  =========  ======  ======     =========  =========  ======  ======
  eth0       22.5       300 M      0       0          22.5       481 M      0       0
  eth1       137791     342208 M   0       4494 (0%)  137791     357979 M   0       0
  eth2       408590     392561 M   0       373 (0%)   408590     330736 M   0       0
  eth4       35461.6    55232 M    0       2350 (0%)  35461.6    35536 M    0       0
```



**Run on a sosreport again, showing sysctls:**

```
[rsaw]$ xsos --sysctl boomyaow/
SYSCTLS
  kernel.
    hostname =  boomyaow03
    osrelease =  2.6.32-220.13.1.el6.x86_64
    tainted =  0  (kernel untainted)
    random.boot_id =  defb55c5-c2bb-4e4e-86c3-745d80a6585d
    random.entropy_avail [bits] =  154
    hung_task_panic [bool] =  0
    hung_task_timeout_secs =  120  (secs task must be D-state to trigger)
    msgmax [bytes] =  65536
    msgmnb [bytes] =  65536
    msgmni [msg queues] =  32768
    panic [secs] =  0  (no autoreboot on panic)
    panic_on_oops [bool] =  1
    panic_on_unrecovered_nmi [bool] =  0
    pid_max =  32768
    threads-max =  1029998
    sem [array] =  250  32000  32  4096
      SEMMSL (max semaphores per array) =  250
      SEMMNS (max sems system-wide)     =  32000
      SEMOPM (max ops per semop call)   =  32
      SEMMNI (max number of sem arrays) =  4096
    shmall [4-KiB pages] =  4294967296  (16384.0 GiB max total shared memory)
    shmmax [bytes] =  68719476736  (64.00 GiB max segment size)
    shmmni [segments] =  4096  (max number of segs)
    sysrq [bitmask] =  0  (disallowed)
  fs.
    file-max [fds] =  6512672  (system-wide limit on nr open file descriptors)
    file-nr [fds] =  2496  0  6512672  (nr allocated fds, N/A, nr free fds)
    inode-nr [inodes] =  78574  1  (nr_inodes allocated, nr_free_inodes)
  net.
    core.rmem_max [bytes] =  131071  (127 KiB)
    core.wmem_max [bytes] =  131071  (127 KiB)
    core.rmem_default [bytes] =  124928  (122 KiB)
    core.wmem_default [bytes] =  124928  (122 KiB)
    ipv4.icmp_echo_ignore_all [bool] =  0
    ipv4.ip_forward [bool] =  0
    ipv4.tcp_max_orphans [sockets] =  65536  (4096 MiB @ max 64 KiB per orphan)
    ipv4.tcp_mem [4-KiB pages] =  6179904  8239872  12359808  (23.57 GiB, 31.43 GiB, 47.15 GiB)
    ipv4.udp_mem [4-KiB pages] =  6179904  8239872  12359808  (23.57 GiB, 31.43 GiB, 47.15 GiB)
    ipv4.tcp_window_scaling [bool] =  1
    ipv4.tcp_rmem [bytes] =  4096  87380  4194304  (4 KiB, 85 KiB, 4096 KiB)
    ipv4.tcp_wmem [bytes] =  4096  16384  4194304  (4 KiB, 16 KiB, 4096 KiB)
    ipv4.udp_rmem_min [bytes] =  4096  (4 KiB)
    ipv4.udp_wmem_min [bytes] =  4096  (4 KiB)
  vm.
    dirty_ratio =  20  (% of total system memory)
    dirty_bytes =  0  (disabled -- check dirty_ratio)
    dirty_background_ratio =  10  (% of total system memory)
    dirty_background_bytes =  0  (disabled -- check dirty_background_ratio)
    dirty_expire_centisecs =  3000
    dirty_writeback_centisecs =  500
    nr_hugepages [2-MiB pages] =  0
    overcommit_memory [0-2] =  0  (heuristic overcommit)
    overcommit_ratio =  50
    oom_kill_allocating_task [bool] =  0  (scan tasklist)
    panic_on_oom [0-2] =  0  (no panic)
    swappiness [0-100] =  60
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
    Ser:  CZ3XXXXXXXX
    UUID: 35344D41-XXXXXX-5A43-3331-XXXXXXXXXXX
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
  Total number of processes:
    1393
  Top users of CPU & MEM:
    USER    %CPU    %MEM      RSS
    oracle  909.8%  60649.2%  38137.57 GiB
    root    130.8%  2.7%      1.93 GiB
  Uninteruptible sleep & Defunct processes:
    USER     PID    %CPU  %MEM  VSZ-MiB  RSS-MiB  TTY    STAT  START  TIME      COMMAND  
    oracle   7883   0.3   59.3  141      38177    ?      Ds    Jul31  2:33      oracleCRELSP4
    oracle   11028  0.1   59.3  154      38170    ?      Ds    Jun30  49:08     ora_arc8_CRELSP4
    oracle   13816  0.0   59.3  140      38171    ?      Ds    Jul31  0:12      oracleCRELSP4
    oracle   15184  0.4   59.3  141      38176    ?      Ds    Jul31  3:01      oracleCRELSP4
    oracle   15423  0.5   59.3  143      38179    ?      Ds    Jul31  3:32      oracleCRELSP4
    oracle   17334  0.0   59.3  143      38176    ?      Ds    Jul31  0:14      oracleCRELSP4
    oracle   18502  0.3   59.3  141      38176    ?      Ds    Jul31  2:39      oracleCRELSP4
    root     18514  2.0   0.0   0        0        ?      D<    10:33  0:00      /bin/grep
    oracle   20751  0.8   59.3  143      38178    ?      Ds    Jul31  5:21      oracleCRELSP4
    oracle   24385  0.6   59.3  142      38175    ?      Ds    Jul31  4:05      oracleCRELSP4
    oracle   24557  0.4   59.3  140      38173    ?      Ds    10:22  0:02      oracleCRELSP4
    oracle   24718  1.3   59.3  143      38178    ?      Ds    Jul31  8:57      oracleCRELSP4
    oracle   29008  2.8   59.3  143      38176    ?      Ds    09:38  1:34      oracleCRELSP4  
  Top CPU-using processes:
    USER     PID    %CPU  %MEM  VSZ-MiB  RSS-MiB  TTY    STAT  START  TIME      COMMAND  
    root     18329  104   0.0   50       2        pts/6  R+    10:33  0:03      /bin/netstat
    oracle   11160  19.7  59.3  146      38174    ?      Ss    Jun30  9012:36   oracleCRELSP4
    oracle   14014  10.6  59.3  140      38173    ?      Ss    10:32  0:05      oracleCRELSP4
    root     6455   5.9   0.1   415      83       ?      Sl    Jan25  16265:29  /space/java/jdk1.5.0_20/bin/java
    root     6515   5.3   0.0   0        0        ?      R     Jan14  15483:17  [rpciod]
  Top MEM-using processes:
    USER     PID    %CPU  %MEM  VSZ-MiB  RSS-MiB  TTY    STAT  START  TIME      COMMAND  
    oracle   7847   0.0   59.4  249      38257    ?      Ss    Jun30  0:52      ora_diag_CRELSP4
    oracle   1912   0.0   59.3  160      38185    ?      Ss    Jul22  12:29     ora_j001_CRELSP4
    oracle   10937  0.1   59.3  167      38185    ?      Ss    Jun30  53:14     ora_arc3_CRELSP4
    oracle   10920  0.1   59.3  167      38185    ?      Ss    Jun30  58:05     ora_arc1_CRELSP4
    oracle   11037  0.1   59.3  167      38184    ?      Ss    Jun30  53:33     ora_arc9_CRELSP4
```


REQUIREMENTS
-------

* As detailed in the help page, BASH version 4 (rhel 6+) is required for -i/--ip and for any of the "Special options" like `--C` or `--B`. Colorization is also not done unless BASH v4+ is detected.
* Other than that, nothing special for command requirements -- `xsos` uses standard coreutils & util-linux commands, along with, of course ... `gawk` and `sed`.
* No absolute paths used for commands.
* When running on localhost (i.e. not a sosreport), `xsos` gracefully reports as much of what's requested as possible when running as non-root (`--bios` and `--ethtool` require root privileges; `--disks` won't be able to print dm-multipath output without root privs).


THINGS THAT MIGHT SURPRISE YOU
-------

* xsos does some pretty intensive color-formatting to make the output more easily-readable (can be disabled with `-x` or `--nocolor` and colors can be modified via environment variables).
  * If you like the color but need to use a pager, use the `--less` (`-y`) or `--more` (`-z`) options to auto-pipe output to `less -SR` or `more`.
* There are a bunch of environment variables that you can use to tweak behavior. See [the original commit comment](https://github.com/ryran/xsos/commit/0c05168d3729d44f4ddf07269b33105f85a306de#commitcomment-2133859) for documentation.
* There's a bash autocompletion function defition available for xsos. Use it.
* When printing disk info with `-d/--disks`, xsos automatically detects linux software raid (md) devices and hides their components. The `multipath` command is also consulted to print info about native multipathd devices. All LUNs that are part of a dm-multipath map are also hidden from the disk output.
* You can use the `--unit` (`-u`) option to change how `/proc/meminfo` and `/proc/net/dev` are parsed -- displaying units in anything from bytes up to tebibytes. Note that this option does *not* affect display of the `VSZ` & `RSS` fields in the ps output. (For that, manually set the `XSOS_PS_UNIT` variable to `k`, `m`, or `g`.)


AUTHORS
-------

As far as direct contributions go, so far it's just me, [ryran](/ryran), aka rsaw, aka [Ryan Sawhill Aroha](http://people.redhat.com/rsawhill). That said, many folks have reported bugs and given suggestions for new features:

- Patrick Talbert especially deserves a huge shout-out! Using xsos on sosreports while diagnosing networking issues, he's uncovered many an odd corner case and discussions with him have led to implementing new features and refining what the networking modules show.

- Jamie Bainbridge has been so consistently kind and effusive in expressing his appreciation of xsos. The RFEs he has suggested (at least the ones we've implemented) have surely made xsos a more powerful tool.

- Joe Wright was the first person to request a kdump module. Turned out to be a great idea!

When I was clueless in how to further my awk career early on, two prolific users over on StackOverflow -- [Dennis Williamson](http://stackoverflow.com/users/26428/dennis-williamson) and [ghostdog74](http://stackoverflow.com/users/131527/ghostdog74) -- each provided answers (to two separate questions) with code that was brilliantly instructive. My awk skills have since evolved far beyond what I was trying to do back then, but thanks definitely goes to both of them for that early inspiration.

Please contact me if you have ideas, suggestions, questions, or want to collaborate on this or something similar. For specific bugs and feature-requests, you can [post a new issue on the tracker](/ryran/xsos/issues).


LICENSE
-------

Copyright (C) 2012-2015 [Ryan Sawhill Aroha](http://people.redhat.com/rsawhill)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License @[gnu.org/licenses/gpl.html](http://gnu.org/licenses/gpl.html>) for more details.
