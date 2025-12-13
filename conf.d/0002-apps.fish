#!/usr/bin/env fish

status is-login; or exit

if command -q python
    set -gx PYTHON_HISTORY "$XDG_STATE_HOME/python_history"
    set -gx PYTHONPYCACHEPREFIX "$XDG_CACHE_HOME/python"
    set -gx PYTHONUSERBASE "$XDG_DATA_HOME/python"
end

if command -q rust
    set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
end

if command -q wine
    set -gx WINEPREFIX "$XDG_DATA_HOME/wineprefixes/default"
end
