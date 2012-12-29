rsar - Extract data from plain-text sar files
=============================================

When dealing with sar data in a sosreport, it's almost allways easier to parse through the plain-text sar data files than it is to get the binary sa files onto a system where you can use `sar` to parse through them for exactly what you're looking for.

`rsar` is like the `sar` command, but for sar files. It supports a limited set of the same data-selection options `sar` uses, but can also do generic searches.


INSTALLATION
-------

Simply download [this one file](https://raw.github.com/ryran/xsos/master/rsar) and save it to a directory that's in your `$PATH`. Make it executable and you'll be good to go!  

**Example:**

```
$ su -
# wget -O /usr/local/bin/rsar bit.ly/rsar-direct
# chmod +x /usr/local/bin/rsar
# exit
$ xsos -h
```


USAGE
-----

Perhaps I'll write up something more later. For now, here's the help page:

```
Usage: rsar SARFILE... [-t TIME] [-x SEARCHSTR] [SAROPTIONS]
   or: rsar -?|-h|--help

Note: GNU getopt is used for arg-parsing -- order of arguments is arbitrary
  
SARFILE -- need at least 1 plaintext sar data file (optionally compressed)
  Spaces in SARFILE name or path will break things

TIME is a regex for what time period to display
  eg: '^1[2-5]' or ':[23]0:' or '^(0[6-9]|1[23])'

SAROPTIONS is any mix of regular sar data-selection options, ie any of:
  -B -d -n -q -r -R -u -v -w -W -y
  plus non-standard: -E, for interface errors

SEARCHSTR may be used only once and is a regex for what section(s) to select
  eg: 'svctm', 'iowait', 'runq', 'memfree|fault'

SAROPTIONS and -x SEARCHSTR may be used together
If neither are provided, rsar shows CPU utilization (like sar does)

Simple examples:
  rsar sar03 -q -t^2
  rsar sar25 -t^15:30 -x iowait /tmp/sar26.gz /tmp/sar27.xz
  
STOP READING NOW if you're confused; that ^^ is all you need to know

Additional optional selectors:

  -z  Disables auto-selection of the lines beginning with 'Average:'
  
  -D BLOCKDEV  Where BLOCKDEV is a regex for which block devices to select
    e.g.: 'dev8-16' or '7.$' or 'sda2|rootlv'
  
  -N NETDEV  Where NETDEV is a regex for which interfaces to select
    e.g.: 'eth0' or 'eth[12]' or 'bond[1-3]'
  
  -P CPU  Where CPU is handled the same way as 'sar -P', namely:
    '-P 1'   shows only info for CPU1
    '-P 0,3' shows CPU0 & CPU3
    '-P ALL' shows all CPUs, plus the combined 'ALL' lines
```

EXAMPLES IN ACTION
------------------

**Single file with no options:**

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
*(output truncated)*


**Single file with time-selection:**

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


**Single file with very specific time-selection and a sar selection-option:**

```
[rsaw:sa]$ rsar -qt '^12:10|16:40' sar22
00:00:01      runq-sz  plist-sz   ldavg-1   ldavg-5  ldavg-15
12:10:01            0      1221      1.14      1.14      1.12
16:40:01            2      1228      1.22      1.25      1.20
Average:            0      1221      1.21      1.21      1.18
```


**Single file with multiple options:**

```
[rsaw:sa]$ rsar sar22 -t2:30 -qrBR
00:00:01      runq-sz  plist-sz   ldavg-1   ldavg-5  ldavg-15
02:30:01            0      1219      1.20      1.21      1.18
12:30:01            0      1218      1.17      1.23      1.17
22:30:01            0      1221      1.12      1.18      1.26
Average:            0      1221      1.21      1.21      1.18

00:00:01    kbmemfree kbmemused  %memused kbbuffers  kbcached kbswpfree kbswpused  %swpused  kbswpcad
02:30:01     77313504  54771944     41.47    499580  47297288  33551744         0      0.00         0
12:30:01     77117468  54967980     41.62    502636  47473628  33551744         0      0.00         0
22:30:01     77075600  55009848     41.65    503276  47515708  33551744         0      0.00         0
Average:     77145109  54940339     41.59    502192  47449826  33551744         0      0.00         0

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


**Interface-specific data from multiple compressed files:**

```
[rsaw:sa]$ rsar -N eth4 -n sar24.gz -t^19:[12] sar26.bz2 
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


AUTHORS
-------

So far it's just me, [ryran](/ryran), aka rsaw, aka [Ryan Sawhill](http://b19.org).

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

