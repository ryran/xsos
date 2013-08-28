rsar - Extract data from plain-text sar files
=============================================

When dealing with sysstat sar data in a sosreport, it's almost always easier to parse through the plain-text sar data files than it is to get the binary sa files onto a system where you can use `sar` to parse through them for exactly what you're looking for.

The goal behind `rsar` is to make this process a little bit easier. rsar is like the `sar` command, but for plain-text sar files instead of sa files. It supports almost all of the same data-selection options `sar` uses.


INSTALLATION
-------

Two choices:

1. **Manual install:**
   Get the very latest (potentially bleeding-edge) version directly by downloading the main rsar file from [bit.ly/rsar-direct](http://bit.ly/rsar-direct) (which points to [raw.github.com/ryran/xsos/master/rsar](https://raw.github.com/ryran/xsos/master/rsar)). Updating will need to be done manually by re-downloading it.
   Explicitly, you could run the following as root:
   
    ```
    wget -O /usr/local/bin/rsar bit.ly/rsar-direct
    chmod +x /usr/local/bin/rsar
    ```

2. **RPM/Yum repo (recommended):**
   Configure access to the Fedora/RHEL6+ yum repository @ [people.redhat.com/rsawhill/rpms](http://people.redhat.com/rsawhill/rpms/) and install the [potentially not-as-bleeding-edge] rsar RPM from there. Updating can happen automatically along with the rest of your system.
   Two-step instructions @ [How to install xsos or rsar via yum?](https://github.com/ryran/xsos/issues/67#issuecomment-23339115)

Once rsar is installed by one of the above methods, run `rsar -h` as a normal user to see the help page and get started.


USAGE
-----


**`rsar` has an extensive help page. Use it. Feel free to make it better.
Here's what it looks like in v0.1.0rc6:**

```
Usage: rsar SARFILE... [--12hr] [--hn] [--noxh] [-t TIME] [SAROPTS] [DRILLDOWN]
 SAROPTS is any mix of: [-AbBcdHInqrRSuvwWy]
 DRILLDOWN is any mix of: [-P CPU] [-D DISK] [-N NIC]
 Note that getopt is used for arg-parsing (so argument order is arbitrary)

rsar requires at least 1 plaintext sar data file (optionally-compressed)
  Spaces in SARFILE name or path will break things (complain if you care)
  Supported file extensions for compressed sar files:
    z, gz, gzip, b, b2, bz, bz2, bzip, bzip2, x, xz, lzma
    
Opts Specific to rsar:
  --12hr         Switch input format from default 24-hr to 12-hr AM/PM
  --hn           Show hostname/kernel version lines from each sar file
  --noxh         Hide extra column header lines (usually indicative of reboots)
  -t <TIME>      Where TIME is a regex for time period to display
                   Ex: '^1[2-5]' or ':[23]0:' or '^(0.:40|2.:40)' or '^12.*AM'
  -x <PATTERN>   Where PATTERN is used to select a section
                   Ex: 'svctm', 'iowait', 'runq', 'proc|cswch'
                   Recommended to stick with below sar opts to avoid collisions
  -z             Disable showing 'Average:' lines
                   Hint: To show _only_ 'Average:' lines, use -t Av

Standard sar Selection Opts:
  -A { 5 | 6 | 7 }
          Like sar -A: alias for all selection opts (excl. -d & -n)
            The required number corresponds with a major RHEL version
  -b      I/O and transfer rate statistics
  -B      Paging statistics
  -c      Process creation statistics
  -d      Block device statistics
  -H      Hugepages utilization statistics
  -I { SUM }
          Interrupts statistics
  -n { <KEYWORD> [,...] | ALL }
          Network statistics
            KEYWORD may be any of the following (case-insensitive):
            DEV    Network interfaces
            EDEV   Network interfaces (errors)
            NFS    NFS client
            NFSD   NFS server
            SOCK   Sockets      (v4)
            IP     IP traffic   (v4)
            EIP    IP traffic   (v4) (errors)
            ICMP   ICMP traffic (v4)
            EICMP  ICMP traffic (v4) (errors)
            TCP    TCP traffic  (v4)
            ETCP   TCP traffic  (v4) (errors)
            UDP    UDP traffic  (v4)
            SOCK6  Sockets      (v6)
            IP6    IP traffic   (v6)
            EIP6   IP traffic   (v6) (errors)
            ICMP6  ICMP traffic (v6)
            EICMP6 ICMP traffic (v6) (errors)
            UDP6   UDP traffic  (v6)
  -q      Queue length and load average statistics
  -r      Memory utilization statistics
  -R      Memory statistics
  -S      Swap space utilization statistics
  -u      CPU utilization statistics
  -v      Kernel table statistics
  -w      System switching statistics
  -W      Swapping statistics
  -y      TTY device statistics
  
  Note that args passed to -I & -n & -P are cumulative and case-insensitive
    Ex: -n Dev,eDEV works, as does -n Dev -n eDEV -n icmp as does -nALL
        -P all works, as does -P 0,4,7, as does -P0 -P 4 -P 3. -P '[78]|22'

Drill-Down Opts:
  -P { <CPU> [,...] | ALL }
              Where CPU can be comma-separated list of CPU-numbers (like sar)
                Else, if 'ALL' is used, then everything will be shown
                Unlike with sar, CPU can also be a regex
                Ex: '1,4,6' or '1|4|6' or '0,[1-3]0'
  -D <DISK>   Where DISK is a regex for which block devices to select
                Ex: 'dev8-16' or '7.$' or 'sda2|rootlv'
  -N <NIC>    Where NIC is a regex for which network interfaces to select
                Ex: 'eth0' or 'eth[12]' or 'bond[1-3]|em1'

Examples:
  rsar sar03 -qut ^2
  rsar sar03 -P all -t Average
  rsar -t^09:30 -n edev,sock -N eth3 -I sum sar19.bz2
  rsar -x iowait -P [0-3] -t^15:30 /tmp/sar26.gz /tmp/sar27.xz -RB
  
Version info: rsar v0.1.0rc6 last mod 2013/02/16
See <github.com/ryran/xsos> to report bugs or suggestions
```



EXAMPLES IN ACTION
------------------


**rsar doesn't read binary files; it's meant to read `sar`-generated plain-text sar files. Reading a single file with no options, rsar behaves the same as `sar` would, i.e.: shows the combined cpu-utilization.**

```
[rsaw:sa]$ rsar sa22
rsar: Unable to read file: 'sa22'
Need a plain-text sar data file to continue
[rsaw:sa]$ rsar sar22
00:00:01          CPU     %user     %nice   %system   %iowait    %steal     %idle
00:10:01          all      0.10      0.00      0.08      0.00      0.00     99.82
00:20:01          all      0.09      0.00      0.08      0.00      0.00     99.82
00:30:01          all      0.10      0.00      0.08      0.00      0.00     99.81
00:40:01          all      0.11      0.00      0.09      0.01      0.00     99.80
00:50:01          all      0.10      0.00      0.09      0.01      0.00     99.81
01:00:01          all      0.10      0.00      0.09      0.00      0.00     99.80
01:10:01          all      0.11      0.00      0.11      0.00      0.00     99.78
01:20:02          all      0.09      0.00      0.09      0.00      0.00     99.82
01:30:01          all      0.10      0.00      0.08      0.00      0.00     99.82
01:40:01          all      0.11      0.00      0.08      0.00      0.00     99.80
01:50:01          all      0.09      0.00      0.08      0.00      0.00     99.83
02:00:01          all      0.10      0.00      0.08      0.00      0.00     99.82
02:10:01          all      0.10      0.00      0.08      0.00      0.00     99.82
```
*(Note: Output truncated. That would have shown all available cpu utilization data, including any new header-lines caused by reboots and plus any "Average" lines.)*



**Time-selection is NOT like the `-e` and `-s` options of `sar`; instead, rsar has a `-t` option that takes a regular expression which is matched against the time field in the sar data. Be as specific or as general as you want.**

```
[rsaw:sa]$ rsar sar22 -t ^21
00:00:01          CPU     %user     %nice   %system   %iowait    %steal     %idle
21:00:01          all      0.10      0.00      0.08      0.00      0.00     99.82
21:10:01          all      0.10      0.00      0.08      0.00      0.00     99.82
21:20:01          all      0.09      0.00      0.08      0.00      0.00     99.83
21:30:01          all      0.10      0.00      0.08      0.00      0.00     99.82
21:40:01          all      0.10      0.00      0.08      0.00      0.00     99.82
21:50:01          all      0.09      0.00      0.08      0.00      0.00     99.83
Average:          all      0.10      0.00      0.08      0.00      0.00     99.82
```



**rsar supports many `sar`-specific data-selection options like `-q` for queue/loadavg or `-r` for memory utilization. So here's that, plus a very specific time selection.**

```
[rsaw:sa]$ rsar -qt '^12:10|16:40' sar22 -r
00:00:01      runq-sz  plist-sz   ldavg-1   ldavg-5  ldavg-15
12:10:01            0      1221      1.14      1.14      1.12
16:40:01            2      1228      1.22      1.25      1.20
Average:            0      1221      1.21      1.21      1.18

00:00:01    kbmemfree kbmemused  %memused kbbuffers  kbcached kbswpfree kbswpused  %swpused  kbswpcad
12:10:01     77117704  54967744     41.62    502620  47472612  33551744         0      0.00         0
16:40:01     77067032  55018416     41.65    502904  47516168  33551744         0      0.00         0
Average:     77145109  54940339     41.59    502192  47449826  33551744         0      0.00         0
```



**For those unfamiliar with `sar` options, regex searching for headers with `-x` is supported. You can also use `-P` in the same way as with the `sar` command, namely, to specify which CPUs to display info for (comma-separated numbers or else `ALL` to see each CPU + combined avg). With this example output, we can see how easy rsar makes it to spot in the data when a system was rebooted -- no scrolling halfway through the file necessary.**

```
[rsaw:sa]$ rsar sar22 -t'^1(3:5|4:[0-5])' -x nice -P 0,9
00:00:01          CPU     %user     %nice   %system   %iowait    %steal     %idle
13:50:01            0      0.05      0.00      0.12      0.00      0.00     99.82
13:50:01            9      0.02      0.00      0.01      0.00      0.00     99.97
14:00:01            0      5.38      0.00      0.22      0.00      0.00     94.40
14:00:01            9      0.05      0.00      0.10      0.00      0.00     99.84
14:10:01            0      0.04      0.00      0.05      0.00      0.00     99.91
14:10:01            9      0.01      0.00      0.02      0.00      0.00     99.97
14:20:01            0      0.04      0.00      0.13      0.00      0.00     99.83
14:20:01            9      0.01      0.00      0.00      0.00      0.00     99.98
Average:            0      0.13      0.00      0.07      0.00      0.00     99.80
Average:            9      0.02      0.00      0.05      0.00      0.00     99.92
14:40:01          CPU     %user     %nice   %system   %iowait    %steal     %idle
14:50:01            0      0.22      0.00      0.19      0.01      0.00     99.58
14:50:01            9      0.03      0.00      0.01      0.00      0.00     99.96
Average:            0      0.08      0.00      0.08      0.00      0.00     99.84
Average:            9      0.03      0.00      0.05      0.00      0.00     99.91
[rsaw:sa]$ grep -i restart sar22
14:31:23          LINUX RESTART
```



**Paging & page info:**

```
[rsaw:sa]$ rsar sar22 -t2:30 -BR
00:00:01     pgpgin/s pgpgout/s   fault/s  majflt/s
02:30:01         0.59    340.28  13167.06      0.00
12:30:01         0.11    339.28  13130.51      0.00
22:30:01         0.11    350.35  13141.76      0.00
Average:        53.62    379.68  13026.00      0.01

00:00:01      frmpg/s   bufpg/s   campg/s
02:30:01         0.78      0.01     -0.05
12:30:01        -2.04      0.00      0.19
22:30:01        -1.42      0.00      0.19
Average:        -0.80      0.01      0.70
```



**Interface-specific selection (`-N`) of network stats from multiple compressed files:**

```
[rsaw:sa]$ rsar -n DEV -N eth4 sar24.gz -t^19:[12] sar26.bz2 
------------------------ sar24.gz ------------------------
00:00:01        IFACE   rxpck/s   txpck/s   rxbyt/s   txbyt/s   rxcmp/s   txcmp/s  rxmcst/s
19:10:01         eth4      2.42      2.56    203.47    225.20      0.00      0.00      0.00
19:20:01         eth4      2.41      2.57    210.17    224.31      0.00      0.00      0.00
Average:         eth4      2.42      2.56    205.99    224.09      0.00      0.00      0.00

------------------------ sar26.bz2 ------------------------
00:00:01        IFACE   rxpck/s   txpck/s   rxbyt/s   txbyt/s   rxcmp/s   txcmp/s  rxmcst/s
19:10:01         eth4      2.43      2.55    204.02    224.23      0.00      0.00      0.00
19:20:01         eth4      2.41      2.57    205.94    225.02      0.00      0.00      0.00
Average:         eth4      2.42      2.56    206.07    224.04      0.00      0.00      0.00
```



**Disk stats via regex (could also use the `sar` option: `-d`).**

```
[rsaw:sa]$ rsar -x await sar19 -t^04:[0-4]
00:00:01          DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
04:00:01       dev8-0      0.14      0.00      1.79     12.92      0.00      1.37      0.81      0.01
04:00:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:10:01       dev8-0      0.22      6.28      2.28     39.51      0.00      1.74      1.04      0.02
04:10:01      dev8-16      0.14      0.00      2.07     15.33      0.00      2.83      0.88      0.01
04:20:01       dev8-0      0.19      0.00      2.40     12.74      0.00      1.78      0.80      0.02
04:20:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:30:01       dev8-0      0.19      0.00      2.35     12.46      0.00      1.42      0.65      0.01
04:30:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:40:01       dev8-0      0.19      0.00      2.48     13.05      0.00      1.61      0.75      0.01
04:40:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
Average:       dev8-0      0.23      1.00      2.37     14.56      0.00      1.60      0.88      0.02
Average:      dev8-16      0.07      0.01     14.89    218.58      0.00      5.12      1.44      0.01
```



**And just like with network interfaces, there's an option to specify specific block devices. Here I did that (`-D`) along with the `-z` option to hide the "Average" lines, plus threw in network errs (`-n edev`).**
```
[rsaw:sa]$ rsar -x await sar19 -t^04:[0-4] -D 16 -zn edev -N eth0
00:00:01          DEV       tps  rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util
04:00:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:10:01      dev8-16      0.14      0.00      2.07     15.33      0.00      2.83      0.88      0.01
04:20:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:30:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:40:01      dev8-16      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00

00:00:01        IFACE   rxerr/s   txerr/s    coll/s  rxdrop/s  txdrop/s  txcarr/s  rxfram/s  rxfifo/s  txfifo/s
04:00:01         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:10:01         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:20:01         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:30:01         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
04:40:01         eth0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
```



AUTHORS
-------

So far it's just me, [ryran](/ryran), aka rsaw, aka [Ryan Sawhill](http://b19.org).

Please contact me if you have ideas, suggestions, questions, or want to collaborate on this or something similar. For specific bugs and feature-requests, you can [post a new issue on the tracker](/ryran/xsos/issues).


LICENSE
-------

Copyright (C) 2013 [Ryan Sawhill](http://b19.org)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License @[gnu.org/licenses/gpl.html](http://gnu.org/licenses/gpl.html>) for more details.

