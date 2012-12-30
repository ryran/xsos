rsar - Extract data from plain-text sar files
=============================================

When dealing with sysstat sar data in a sosreport, it's almost always easier to parse through the plain-text sar data files than it is to get the binary sa files onto a system where you can use `sar` to parse through them for exactly what you're looking for.

The goal behind `rsar` is to make this process a little bit easier. rsar is like the `sar` command, but for plain-text sar files instead of sa files. It supports a limited set of the same data-selection options `sar` uses.


INSTALLATION
-------

Simply download [this one file](https://raw.github.com/ryran/xsos/master/rsar) and save it to a directory that's in your `$PATH`. Make it executable and you'll be good to go!  

**Example:**

```
$ su -
# wget -O /usr/local/bin/rsar bit.ly/rsar-direct
# chmod +x /usr/local/bin/rsar
# exit
$ rsar -h
```



USAGE
-----


`rsar` has a brief help page. Use it. Feel free to make it better.



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
[rsaw:sa]$ rsar -nN eth4 sar24.gz -t^19:[12] sar26.bz2 
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



**And just like with network interfaces, there's an option to specify specific block devices. Here I did that (`-D`) along with the `-z` option to hide the "Average" lines, plus threw in network errs (`E`).**
```
[rsaw:sa]$ rsar -x await sar19 -t^04:[0-4] -D 16 -zEN eth0
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

Copyright (C) 2012 [Ryan Sawhill](http://b19.org)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License @[gnu.org/licenses/gpl.html](http://gnu.org/licenses/gpl.html>) for more details.

