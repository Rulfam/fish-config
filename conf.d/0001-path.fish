#!/usr/bin/env fish

status is-login; or exit

# Symfony
if test -x "$XDG_DATA_HOME/symfony5/bin/symfony/symfony"
    fish_add_path -a -g "$XDG_DATA_HOME/symfony5/bin/symfony"
end

# XDG_BIN_HOME
if set -q "$XDG_BIN_HOME"; and test -e "$XDG_BIN_HOME"
    fish_add_path -a -g "$XDG_BIN_HOME"
end

# Perl
if command -q perl
    for dir in 'core_perl' 'site_perl' 'vendor_perl'
        test -d "/usr/bin/$dir"
        and fish_add_path -a -g "/usr/bin/$dir"
    end
end

# Java Virtual Machine
if command -q java
    fish_add_path -a -g '/usr/lib/jvm/default/bin'
end
