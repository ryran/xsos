Changelog for xsos & rsar
===================================================
In descending chronological order with most recent commits on top. See **[commit history page](/ryran/xsos/commits/master)** to browse code.

- - -

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
