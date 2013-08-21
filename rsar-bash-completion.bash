# This file is part of rsar, providing intelligent rsar tab-completion for BASH
# Save it to: /etc/bash_completion.d/
#
# Revision date:  2013/08/21, matching up with rsar v0.1.1
# Latest version: <http://github.com/ryran/xsos>
# 
# Copyright 2013 Ryan Sawhill Aroha <rsaw@redhat.com>
# 
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#    General Public License <gnu.org/licenses/gpl.html> for more details.
#
#-------------------------------------------------------------------------------

_rsar()  {
  
  # Variables
  local curr prev shrtopts longopts
  
  # Wipe out COMPREPLY array
  COMPREPLY=()
  
  # Set cur & prev appropriately
  curr=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}
  
  # Short and long options
  shrtopts="-t -x -z -D -N
            -A -b -B -c -d -H -I -n -P -q -r -R -S -u -v -w -W -y"
            
  longopts="--help --version --12hr --hn --noxh"
  
  # Check previous arg to see if we need to do anything special
  case "$prev" in
  
      # Disable autocompletion for solo opts and opts that we can't guess args for
      --help|--version|--update|-D)
          return
          ;;
      -t)
          COMPREPLY=( $(compgen -W "Average" -- "$curr") )
          return
          ;;
      -A)
          COMPREPLY=( $(compgen -W "5 6 7" -- "$curr") )
          return
          ;;      
      -N)
          #COMPREPLY=( $(compgen -W "eth bond" -- "$curr") )
          return 0
          ;;
      -P)
          COMPREPLY=( $(compgen -W "ALL" -- "$curr") )
          return 0
          ;;
      -I)
          COMPREPLY=( $(compgen -W "sum" -- "$curr") )
          return 0
          ;;
      -n)
          COMPREPLY=( $(compgen -W "all dev edev nfs nfsd sock" -- "$curr") )
          return 0
          ;;
      # Some healthy suggestions for -x regex
      -x)
          COMPREPLY=( $(compgen -W "proc cswch %nice %sys %iowait INTR intr pswpin tps bread frmpg bufpg campg TTY rxpck txpck rxerr txerr coll retrans scall badcall hit miss pgpgin fault kbmemfree %memused %swpused kbswpfree dentunusd inode runq-sz plist-sz ldavg DEV avgrq-sz await svctm totsck tcpsck udpsck kbhugfree %hugused" -- "$curr") )
          return 0
          ;;
          
  esac
  
  # Now that we've made it past the options that require args,
  # we can enable filename completion
  compopt -o default
   
  if [[ $curr == --* ]]; then
      # If current arg starts w/2 dashes, attempt to autocomplete long opts
      COMPREPLY=( $(compgen -W "$longopts" -- "$curr") )
      return 0
  elif [[ $curr == -* ]]; then
      # Otherwise, if current only starts w/1 dash, attempt autocomplete short opts
      COMPREPLY=( $(compgen -W "$shrtopts" -- "$curr") )
      return 0
  fi
}

# Add the names of any rsar aliases (or alternate file-names) to the end of the following line
complete -F _rsar rsar

