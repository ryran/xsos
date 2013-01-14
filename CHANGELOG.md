xsos/rsar Changelog
===================================================

**2013/01/13 [xsos v0.1.4: re-wrote grub-detection code; grub2 works now](https://github.com/ryran/xsos/commit/ce9544b53116a2d54c2973de1d009cb82ea6e73f)**

* Closed [issue 30 - RFE: Have OS detect stuff on grub2 systems](https://github.com/ryran/xsos/issues/30). See that for the full details of how grub-detection changed.

  
**2013/01/13 [xsos v0.1.3: massive rewrite (& improvement) of selinux detection code](https://github.com/ryran/xsos/commit/f31adecbc46ea74656c2591b3439be3292abb3b4)**

* Improved SELinux detection code, both for sosreports and for localhost. See the now-closed [issue 31](https://github.com/ryran/xsos/issues/31#issuecomment-12200458) for a full explanation


**2013/01/13 [rsar v0.0.5: added -S & -H; added bash autocompletion file](https://github.com/ryran/xsos/commit/8cde66eb1920f7b02bc7bf12a3672c8dbee630c0)**

* Simple enough -- added `-S` for swap and `-H` for hugepages, along with an `rsar` bash autocompletion file


**2013/01/13 [xsos added bash-completion file yaaaaay](https://github.com/ryran/xsos/commit/8bb6da0fd2018f5667e4d35321d27fdcc8eff198)**

* Updated xsos readme. Finally added a couple screenshots. Cleaned up a couple things.
* Added [xsos-bash-completion.bash](https://github.com/ryran/xsos/blob/master/xsos-bash-completion.bash) file, closes [issue 36 - RFE: Add bash completion file for xsos](https://github.com/ryran/xsos/issues/36). Simply save the file to: `/etc/bash_completion.d/` ... If running xsos from RHEL6, you probably need to install the bash-completion package from EPEL. :)


**2013/01/10 [xsos v0.1.2: meminfo asciiart graphing; random addtl tweaks](https://github.com/ryran/xsos/commit/19d86482afa109d0e797ee5765523eff1315367f) + a few more commits, up to v0.1.2b**

* Added asci-art graphing to meminfo, along with some pretty colors, closing [issue 39 - RFE: Add asci-art/graph for meminfo-display](https://github.com/ryran/xsos/issues/39).
* Re-factored meminfo code quite a bit and cleaned up output display. See above closed issue for new look.
* Changed the default color of the `XSOS_COLOR_IMPORTANT` variable to simple *bold* (from cyan).
* Made pscheck display total number of processes
* Made pscheck honor the global indentation variables (still not used everywhere else, e.g. not in meminfo)
* Did some code refactoring to netdev parsing
* Tweaked osinfo wording for /proc/stat
* More changes to sysctl -- added a few *fs* & **kernel* sysctls
* Hard-coded the `pzero` variable to "xsos". People here at Red Hat were redistributing the script with the file being named custom names (e.g. "x") and didn't know what xsos was really called.


**2013/01/06 [xsos v0.1.1beta: rewrote sysctl-parsing function for ease of mgmt](https://github.com/ryran/xsos/commit/63d4568e42115949287db992fa23a1c3393b07ff)**

* Function-ified everything in the sysctl function to make everything easier (i.e., reading the code, adding things, and tweaking formatting).
  * Also, I'd like to add the ability to read in files created by `sysctl -a` and this work laid the foundation for that.
* Added multiple new sysctls.
* Added or improved descriptions for multiple existing sysclts.
* Improved color-formatting of sysctls.


**2013/01/04 [xsos v0.1.0: massive overhaul of --sysctl](https://github.com/ryran/xsos/commit/8239234042beb79bfb5eb0b25879c60421d16123)**

* In retrospect, this isn't very massive, compared to v0.1.1beta.


**[2013/01/01 rsar v0.0.3: works with symlinked sar files; improved speed](https://github.com/ryran/xsos/commit/0231a862a20679ea69c52f36e18d8313b5a02e6a)**

* Just like it says -- rewrote some code to make reading symlinked files possible.
  * As a side effect, the new code is faster. yay.
  
  
**2012/12/29 [rsar v0.0.2: a few tweaks](https://github.com/ryran/xsos/commit/1e7bb7df16a9714108c2204966daea20b8635abe)**

* Improved a couple little things


**2012/12/28 [added rsar -- a sar-data parser](https://github.com/ryran/xsos/commit/528830aa78dde2a0772d7166768ad5e295bc71ac)** + **[v0.0.1: rsar initial version](https://github.com/ryran/xsos/commit/36559f93f4025d0259722ec86ab1bd595c66d8a7)**

* Initial commits for `rsar`.


**For changelogs farther back than this, you'll need to inspect [individual commits](https://github.com/ryran/xsos/commits/master). Virtually every one came with a changelog.**
