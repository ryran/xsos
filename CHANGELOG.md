Changelog for xsos & rsar
===================================================
In descending chronological order with most recent commits on top. See **[commit history page](/ryran/xsos/commits/master)** to browse code.

- - -

**2015/01/01 xsos v0.5.5: #90, #108 (new module --softirq/-r), #110**

- Implemented Jamie's [issue 108 - RFE: Alert on network SoftIRQ backlog or budget drops](https://github.com/ryran/xsos/issues/108)
- Updated bash completion file to account for 3 new options (`-r`, `--R`, `--softirq`)
- Implemented Patrick's [issue 90 - RFE: Add tcp_timestamps to sysctl output](https://github.com/ryran/xsos/issues/90)
- Implemeneted [issue 110 - RFE: explicitly require gawk instead of awk](https://github.com/ryran/xsos/issues/110)


**2015/01/01 xsos v0.5.4: fix division by zero error if weird NETDEV input**

- Fixed [issue 109 - awk division by zero error in NETDEV output](https://github.com/ryran/xsos/issues/109)


**2014/09/22 xsos v0.5.3: fix for issue #107**

- Fixed [issue 107 - xsos -k hangs indefinitely](https://github.com/ryran/xsos/issues/107)


**2014/09/15 xsos v0.5.2: fix for issue #106**

- Fixed [issue 106 - xsos -g doesn't handle it gracefully if an ifcfg-bond* file has multiple BONDING_OPTS declarations](https://github.com/ryran/xsos/issues/106)


**2014/09/03 xsos v0.5.1: more enhancements to --ip**

- Closed [issue 104 - xsos --ip --ipv6 improperly handling interfaces with multiple addrs](https://github.com/ryran/xsos/issues/104)
- Fixed [issue 105 - --ip --scrub-ip leaks too much information](https://github.com/ryran/xsos/issues/105) and also changed the character the scrub-ip & scrub-mac options use from `X` to `⣿`


**2014/09/02 xsos v0.5.0: completely reworked --ip output #102**

- Closed [issue 102 - RFE: xsos --ip --ipv6 should tag link-local addresses as such](https://github.com/ryran/xsos/issues/102)
- As part of that, the columns for `--ip` were completely re-arranged and a "Scope" column was added for IPv6


**2014/08/29 xsos v0.4.5: --ip fix for issue #103**

- Closed [issue 103 - xsos --ip problems](https://github.com/ryran/xsos/issues/103)


**2014/07/21 xsos v0.4.4: color fix for issue 100**

- Closed [issue 100 - xsos -t / --mpath doesn't reset color properly when no paths detected](https://github.com/ryran/xsos/issues/100)


**2014/06/22 xsos v0.4.3: rhel7 fixes for --kdump & /proc/cmdline**

- See ongoing [issue 97 - catchall for RHEL7 issues](https://github.com/ryran/xsos/issues/97)


**2014/06/13 xsos v0.4.2: added to bios display; added rhel7 issue support**

- Modified `-b` / `--bios` display to show more info, per [issue 98 - RFE: Add dmidecode "Firmware Revision" to xsos BIOS page](https://github.com/ryran/xsos/issues/98)
- Added RHEL7 to supported systems regex due to GA release a couple days ago (really only affects colorization with `--os`) and tweaked the way `/etc/os-release` is parsed


**2014/05/07 xsos v0.4.1: changed sysctl value color to simple bold**

- Changed sysctl values to use "important" color instead of h3 color (as far as defaults go, that means instead of blue, the values will be just bold)


**2014/05/07 xsos v0.4.0: issue95 & issue96**

- Fixed [issue 95 - taintcheck in xsos -s and xsos -o has problems](https://github.com/ryran/xsos/issues/95)
- Implemented [issue 96 - RFE: xsos --sysctl need moar better](https://github.com/ryran/xsos/issues/96)


**2014/05/02 xsos v0.3.9: quick fix for issue94**

- Fixed [issue 94 - xsos --bonding shows multiple MAC addrs on slave interface](https://github.com/ryran/xsos/issues/94) 


**2014/01/10 xsos v0.3.8: speed improvement for --lspci**

- Improved speed of lspci processing


**2014/01/06 xsos v0.3.7: fix for line 2100: syntax error: invalid arithmetic operator**

- Fixed [issue 87 - xsos: line 2100: eth0_12@eth0: syntax error: invalid arithmetic operator (error token is "@eth0")](https://github.com/ryran/xsos/issues/87)


**2013/12/27 xsos v0.3.6: enhancements to ethtool error-parsing**

- See [discussion on ethtool interface error parsing](https://github.com/ryran/xsos/issues/85) for full details
- Added `XSOS_ETHTOOL_ERR_REGEX` env variable (`XSOS_ETHTOOL_ERR_REGEX="(drop|disc|err|fifo|buf|fail|miss|OOB|fcs|full|frags|hdr|tso).*: [^0]"`)
- Added multiple items to above-mentioned regex
- Completely re-tooled the error parsing to gracefully handle `ethtool -S` output with multiple Rx/Tx queues (i.e., if errors are found, the queue heading is printed)
- As a consequence of indentation being used in `ethtool -S` output more and more, xsos no longer replaces all leading whitespace with the `XSOS_INDENT_H2` variable -- instead we just insert the interface name plus a couple spaces and call it good
- Fixed [issue 86 - xsos -n shows same value for RX & TX bytes!](https://github.com/ryran/xsos/issues/86)


**2013/12/17 xsos v0.3.5: added MTU, --scrub-ip & --scrub-mac**

- Added MTU column to `--ip`
- Replaced `--scrub` with `--scrub-ip` & changed `XSOS_SCRUB_OUTPUT` env variable to `XSOS_SCRUB_IP_HN`
- Added `--scrub-mac` and `XSOS_SCRUB_MACADDR `env var to scrub MACs from bonding and ipaddr output
- Updated bash-completion file


**2013/12/16 xsos v0.3.4: multiple env variable changes; ethtool; rhel5 mktemp**

- Colors: `XSOS_COLOR_*` variables now must be defined as simple words -- blue, cyan, red, etc. and BLUE, CYAN, RED, etc. (for bold). Note that users don't need to define these -- they have defaults. But if one wanted to, they could tweak them as environment variables (in e.g. `~/.bash_profile`).
- `XSOS_ALL_VIEW` & `XSOS_DEFAULT_VIEW` environment variables now take simple modules names instead of obfuscated `x=y;` syntax, i.e.: to change the default view seen when xsos is run with no options, you could run `XSOS_DEFAULTVIEW="bios cpu mem" xsos` (or of course set it in a config file as mentioned above).
- Made the messaging simpler and hopefully much more clear when updating via `--update` / `-U`
- Added additional logic to `XSOS_FOLD_WIDTH` for when it's set to `w` (autodetect). In such a case, if we don't have a tty (e.g. `ssh somesystem xsos`), it will statically be set to 80 columns.
- Added `fail` and `miss` to the ethtool "Interface Errors" regex
- Fixed invocation of `mktemp` with `--tmpdir` option which RHEL5 doesn't have *sigh* .... made it keep using old deprecated `-p` for now.


**2013/12/07 xsos v0.3.3d: --kdump fix for multiline df output**

- See ongoing [issue 81 - RFE: Add further kdump diagnostics](https://github.com/ryran/xsos/issues/81)
- Changes between 0.3.2 and 0.3.3d:
  - Added kdump.conf path available space check to `--kdump`
  - Added panic-related sysctls and more color to `--kdump`
  - Fixed `--kdump` to appropriately handle multiline `df` output (i.e., when a device is too long to fit on the same line as its stats)


**2013/11/26 xsos v0.3.2: added --scrub option + XSOS_SCRUB_OUTPUT env var**

- See ongoing [issue 80 - RFE: Add option to scrub system identifiable information (i.e., hostnames & IP addrs) for e.g. government use](https://github.com/ryran/xsos/issues/80). So far cleaned up OS, IP, and SYSCTL output.


**2013/11/21 xsos v0.3.1: added new -k/--kdump module; added rdrand to --cpu**

- Added `rdrand` to detected cpu flags (in `--cpu`)
- Implemented [issue 78 - RFE: Add a new module for querying kdump configuration](https://github.com/ryran/xsos/issues/78) via `--kdump` / `-k`


**2013/11/18 xsos v0.3.0: changed iface-down color to lt.grey; ethtool fix**

- Fixed [issue 77 - When `ethtool iface` doesn't report any good output, interface is skipped](https://github.com/ryran/xsos/issues/77)
- Interfaces that exist but don't have proper ethtool output now should show up (along with `link=UNKNOWN`). Such interfaces will be color-coded with the warn1 color (defaults to orange).
- Changed the interface-down color to light grey (from dark grey). This should make it easier to see in both dark and white color schemes.


**2013/11/15 xsos v0.2.9b: sysctl fixes; added net.core.netdev\*, fs.nr_open**

- Implemented [issue 76 - RFE: Display net.core.netdev_max_backlog in sysctls](https://github.com/ryran/xsos/issues/76)
- Added fs.nr_open sysctl
- Tweaked order and descriptions of multiple sysctls


**2013/11/10 xsos v0.2.9: fixed ethtool firmware-version bug; new bash-completion file**

- Fixed [issue 75 - ethtool parsing (-e / --ethtool) truncates firmware-version; only shows first word](https://github.com/ryran/xsos/issues/75)
- Updated xsos bash completion file, adding `-6` and `--ipv6`


**2013/11/07 xsos v0.2.8: changed default fold-width from "94" to "auto-detect"**

- As subject says, fold-width setting (`--width`) has defaulted to 94 columns for a while now, though only some modules use it (most notably, the OS output seen when xsos runs with no opts). New default for this is `w`, which auto-detects the terminal width and uses that.
- Simple code re-factoring
- Help page updates
- Create tmpdir in /dev/shm (in-memory) and export `TMPDIR` env variable as that. Means all of the cool things bash does will use that instead of /tmp (usually on-disk). Additionally, move stderr tmpfile to same /dev/shm tmpdir. (And of course there's a trap to ensure the directory gets deleted when xsos exits or aborts.)


**2013/10/30 xsos v0.2.7: added -6/--ipv6 option which affects --ip**

- Implemented [issue 74 - RFE: Make it possible for -i / --ip to display IPv6 addresses](https://github.com/ryran/xsos/issues/74) via adding new `--ipv6` / `-6` option which changes behavior of `-i` / `--ip`


**2013/10/16 xsos v0.2.6: utilize tmpfile for storing stderr, to show stderr last**

- Implemented [issue 73 - RFE: Make --less & --more handle errors (stderr) appropriately](https://github.com/ryran/xsos/issues/73)


**2013/09/08 xsos v0.2.5 --ip: now parses `brctl show` for bridge funness**

- Closed [issue 72 - RFE: xsos --ip should show what interfaces are slaved to bridge devices](https://github.com/ryran/xsos/issues/72)


**2013/09/08 xsos v0.2.4 small fix for --ethtool on localhost + --ip coloring fix**

- Fixed [issue 71 - in v0.2.2, --ethtool run on localhost causes warnings like: Cannot get device settings: No such device](https://github.com/ryran/xsos/issues/71)
- Fixed some issues with `--ip` introduced in v0.2.2, namely:
    - Fixed green coloring not resetting if `--ip` is the last module run
    - Fixed mis-detection of some lines

**2013/09/06 xsos v0.2.2 implemeted --bonding; added rxring to --ethtool**

- Closed [issue 70 - RFE: Make xsos --ethtool show current/max rx ring buffer setting](https://github.com/ryran/xsos/issues/70)
- Haven't closed [issue 17 - Possible RFE: More detailed bonding information?](https://github.com/ryran/xsos/issues/17) yet, but have implemented it via parsing of `/proc/net/bonding/*` + additional ifcfg-file inspection. This necessitates a new module + new opts: `--bonding` / `-g` / `--G`
- Renamed `--net` to `--netdev`
- Repurposed --net as an alias for: --lspci --ethtool --bonding --ip --netdev
- Added up/down colors to --ip (similar to --ethtool)
- Changed eth device down default color from red to dark grey (--ethtool/--ip)
- Re --bios: Made detection of broken dmidecode output more robust


**2013/08/27 xsos v0.2.1 implemeted -t/--mpath option to parse dm-multipath**

- Closed [issue 68 - RFE: Better way to parse dm-multipath output?](https://github.com/ryran/xsos/issues/68) by adding new MULTIPATH module + a drill-down query option of `-q`/`--wwid`. See closed issue for details.


**2013/08/26 NOTICE: YUM REPOSITORY AVAILBLE**

- Updated installation instructions in the READMES


**2013/08/21 rsar v0.1.1 implemeted RSAR_COLORS env to disable coloring**

- Fixed my name in the header and added info about soon-to-come rpm website
- Checks for `RSAR_COLORS` environment variable; if set and set to anything other than `y`, coloring (incl. bold) will be disabled


**2013/08/21 xsos v0.2.0: time for a version bump. also temp.disabled rhsupport option**

- Fixed my name in the header and added info about soon-to-come rpm website
- Commented out `--rhsupport` option for now, until I can write the logic for it


**2013/07/23 xsos v0.1.12: further improvement (again) to ethtool errors**

- Probably-final tweaks prior to closing of [issue 65 - RFE: Detect packet drops and/or network error counters](https://github.com/ryran/xsos/issues/65)


**2013/07/18 xsos v0.1.11: further improvement to new ethtool error detection**

- More tweaks to implementation of [issue 65 - RFE: Detect packet drops and/or network error counters](https://github.com/ryran/xsos/issues/65)


**2013/07/18 xsos v0.1.10: net & ethtool enhancements; fix for lsb-release**

- Closed [issue 64 - make xsos --os ignore /etc/lsb-release](https://github.com/ryran/xsos/issues/64)
- Closed [issue 66 - RFE: show (TX) collisions from /proc/net/dev in --net](https://github.com/ryran/xsos/issues/66)
- Added initial implementation for [issue 65 - RFE: Detect packet drops and/or network error counters](https://github.com/ryran/xsos/issues/65), adding to what `--ethtool` shows


**2013/04/21 xsos v0.1.9: fix for sos boot time display; added softlockup sysctls**

- Closed [issue 62 - Boot time (in --os output) wrong (showing as UTC) with EDT time zone (along with tons of others)](https://github.com/ryran/xsos/issues/62)
- Added sysctls: kernel.softlockup_panic and kernel.softlockup_thresh
- memgraph code-refactoring
- When checking SELinux status in sosreports: dmesg is now checked AFTER kernel cmdline instead of BEFORE


**2013/02/23 xsos v0.1.8: simple fix for huge bug added in v0.1.7**

- Closed [issue 60 - in xsos v0.1.7, multiple modules don't work on localhost](https://github.com/ryran/xsos/issues/60)


**2013/02/16 rsar v0.1.0rc6: added --noxh option (trapier++)**

- Closed *(probably)* the first issue ever created by someone other than rsaw/ryran/moi -- [issue 59 - rsar RFE: condense duplicate headers](https://github.com/ryran/xsos/issues/59) -- by adding a new `--noxh` option. See the issue for full details.
- Updated [rsar-bash-completion.bash](https://github.com/ryran/xsos/blob/master/rsar-bash-completion.bash) file to handle the two new rsar options.


**2013/02/08 xsos v0.1.7: added nmi sysctls & fixed multipath LUNzz bug**

- Closed [issue 54 - RFE: add nmi sysctls](https://github.com/ryran/xsos/issues/54)
- Closed [issue 57 - multipath component luns are not always hidden](https://github.com/ryran/xsos/issues/57) 
- Don't be surprised by a new `--rhsupport` option on the help page... it's not active yet. Still working on that but wanted to get the fixes for the above 2 issues out there.

**2013/02/04 rsar v0.1.0rc5: added --hn option for trapier. good call.**

- Closed [issue 55 - rsar RFE: add option to make rsar display first line of a sar file](https://github.com/ryran/xsos/issues/55)


**2013/01/26 xsos v0.1.6: a couple bugfixes**

- Closed: [issue 43 - sys time & boot time are formatted differently depending whether reading sosreport or localhost](https://github.com/ryran/xsos/issues/43)
- Closed: [issue 53 - ps function makes assumptions about process names](https://github.com/ryran/xsos/issues/53). Now percentage signs in `ps` input are properly escaped. I also changed the delimiter character used in multiple places from "@" & "~" to "❚" -- makes code easier to read and avoids problems.


**2013/01/23 rsar v0.1.0rc4: massive changes and fixes; see help page**

- Added `-A` option, corresponding with the same sar option. See help page for full details, but it short: it requires specifying the rhel version in order to pick the right options
- Modified `-n` to accept `ALL` as a keyword
- Modified `-P` to allow both the traditional comma-delimited CPU numbers, as well as regex
- Closed: [issue 50 - rsar: -P ALL doesn't work](https://github.com/ryran/xsos/issues/50) (`-P ALL` not appropriately selecting everything)
- Fixed: `-z` not working with 12hr time
- Closed: [issue 51 - rsar: -n IP and -n EIP show the same thing as -n SOCK](https://github.com/ryran/xsos/issues/51)
- Closed: [issue 52 - rsar RFE: rsar's help page is confusing and doesn't explain the sar options](https://github.com/ryran/xsos/issues/52) (massive rewrite of usage/help page)
- As always, the bash-completion script for rsar was updated
- I'm tired.


**2013/01/22 rsar v0.1.0rc3: added --12hr option to handle input with AM/PM**

- Closed [issue 49 - rsar bug: rsar chokes on sar data with AM/PM](https://github.com/ryran/xsos/issues/49) by adding a `--12hr` option to rsar.


**2013/01/20 xsos v0.1.5: big multipath improvements to disk code**

- Closed [issue 48 - --disks option not properly-handling mutlipath output on rhel6.3?](https://github.com/ryran/xsos/issues/48). See that for discussion. In short, I made a bunch of changes to the disk/multipath-handling code.
- Changed the default color for tertiary headers to bold-blue instead of just blue.


**2013/01/16 rsar v0.1.0rc1: made -n opt compatible with sar -n**

- Closed [issue 46 - rsar RFE / BUG: -n opt only shows dev; what about sock, nfs, nfsd, etc?](https://github.com/ryran/xsos/issues/46).

**2013/01/15 rsar v0.0.7: added -I (intr)**

- Closed [issue 44 - rsar RFE: add -I option (for interrupts)](https://github.com/ryran/xsos/issues/44).


**2013/01/14 rsar v0.0.6: big file-handling improvements; see changelog**

- Closed [issue 41 - rsar File-handling is crappy (slow, can't always open compressed files, errors out if any 1 of multiple files are bad or missing)](https://github.com/ryran/xsos/issues/41). See that for full details of what was changed.


**2013/01/13 xsos v0.1.4: re-wrote grub-detection code; grub2 works now**

- Closed [issue 30 - RFE: Have OS detect stuff on grub2 systems](https://github.com/ryran/xsos/issues/30). See that for the full details of how grub-detection changed.

  
**2013/01/13 xsos v0.1.3: massive rewrite (& improvement) of selinux detection code**

- Closed [issue 31 RFE: Improve SELinux detection in sosreports by looking at dmesg](https://github.com/ryran/xsos/issues/31#issuecomment-12200458). See that for full details.


**2013/01/13 rsar v0.0.5: added -S & -H; added bash autocompletion file**

- Closed [issue 45 - rsar RFE: add -S and -H for swap and hugepages](https://github.com/ryran/xsos/issues/45). 
- Also added an `rsar` bash autocompletion file like with xsos below.


**2013/01/13 xsos added bash-completion file yaaaaay**

- Updated xsos readme. Finally added a couple screenshots. Cleaned up a couple things.
- Closed [issue 36 RFE: Add bash completion file for xsos](https://github.com/ryran/xsos/issues/36). Added [xsos-bash-completion.bash](https://github.com/ryran/xsos/blob/master/xsos-bash-completion.bash) file. Simply save the file to: `/etc/bash_completion.d/` ... If running xsos from RHEL6, you probably need to install the bash-completion package from EPEL. :)


**2013/01/10 xsos v0.1.2: meminfo asciiart graphing; random addtl tweaks + a few more commits, up to v0.1.2b**

- Closed [issue 39 - RFE: Add asci-art/graph for meminfo-display](https://github.com/ryran/xsos/issues/39), adding asci-art graphing to meminfo, along with some pretty colors.
- Re-factored meminfo code quite a bit and cleaned up output display. See above closed issue for new look.
- Changed the default color of the `XSOS_COLOR_IMPORTANT` variable to simple *bold* (from cyan).
- Made pscheck display total number of processes
- Made pscheck honor the global indentation variables (still not used everywhere else, e.g. not in meminfo)
- Did some code refactoring to netdev parsing
- Tweaked osinfo wording for /proc/stat
- More changes to sysctl -- added a few *fs* & **kernel* sysctls
- Hard-coded the `pzero` variable to "xsos". People here at Red Hat were redistributing the script with the file being named custom names (e.g. "x") and didn't know what xsos was really called.


**2013/01/06 xsos v0.1.1beta: rewrote sysctl-parsing function for ease of mgmt**

- Function-ified everything in the sysctl function to make everything easier (i.e., reading the code, adding things, and tweaking formatting).
  * Also, I'd like to add the ability to read in files created by `sysctl -a` and this work laid the foundation for that.
- Added multiple new sysctls.
- Added or improved descriptions for multiple existing sysclts.
- Improved color-formatting of sysctls.


**2013/01/04 xsos v0.1.0: massive overhaul of --sysctl**

- In retrospect, this isn't very massive, compared to v0.1.1beta.


**2013/01/01 rsar v0.0.3: works with symlinked sar files; improved speed**

- Just like it says -- rewrote some code to make reading symlinked files possible.
  * As a side effect, the new code is faster. yay.
  
  
**2012/12/29 rsar v0.0.2: a few tweaks**

- Improved a couple little things


**2012/12/28 added rsar -- a sar-data parser + v0.0.1: rsar initial version)**

- Initial commits for `rsar`.


**For changelogs farther back than this, you'll need to inspect [individual commits](https://github.com/ryran/xsos/commits/master). Virtually every one came with a changelog.**
