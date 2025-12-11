#!/usr/bin/env fish

status is-interactive; or exit


# Command names
#------------------------------------------------------------------------------

abbr -a cls 'clear'
abbr -a q 'exit'

command -q fastfetch ; and abbr -a ff 'fastfetch'
command -q fluidsynth; and abbr -a fs 'fluidsynth'
command -q zeditor   ; and abbr -a zed 'zeditor'


# Command arguments
#------------------------------------------------------------------------------

if command -q git
    abbr -a -c git -- c 'commit'
    abbr -a -c git -- C 'clone'
end

if command -q pacman
    abbr -a pm 'pacman'

    abbr -a -c pacman -- get '-S'
    abbr -a -c pacman -- help '-Qi'
    abbr -a -c pacman -- lo '-Qdtq'
    abbr -a -c pacman -- rc '-Scc'
    abbr -a -c pacman -- rm '-Rnsu'
    abbr -a -c pacman -- upd '-Syu'
    abbr -a --set-cursor -c pacman -- find '-Sqs % | column'
    abbr -a --set-cursor -c pacman -- ls '-Qenq% | column'
end


# Miniprograms
#------------------------------------------------------------------------------

# Construct
abbr -a --set-cursor -- FOR 'for i in *; %; end'

# Search
abbr -a --set-cursor -- EXEC 'find . -name "%" -exec echo {} \\; 2>/dev/null'
abbr -a --set-cursor -- FIND 'find . -name "%" 2>/dev/null'
