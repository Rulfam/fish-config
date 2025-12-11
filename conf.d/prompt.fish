#!/usr/bin/env fish

status is-interactive; or exit


# Helper functions
#------------------------------------------------------------------------------

function prompt_login --description 'Display user name for the prompt'
    set -l prompt (_get_colored_user_name) (_get_colored_host_name)

    # Skip the host part if not in detailed mode
    if not set -q use_detailed_prompt
        set prompt (_get_colored_user_name)
    end

    echo -n -s $prompt
end

function _get_colored_user_name
    echo -n -s (set_color $fish_color_user) $USER (set_color normal)
end

function _get_colored_host_name
    set -l color_host $fish_color_host

    # If we're running via SSH, change the host color.
    if set -q SSH_TTY; and set -q fish_color_host_remote
        set color_host $fish_color_host_remote
    end

    set -l HOST (prompt_hostname)
    echo -n -s (set_color $color_host) '@' $HOST (set_color normal)
end

function prompt_pwd --description 'short CWD for the prompt'
    if set -q use_detailed_prompt
        echo -n -s (_concat_slash_to_dir $PWD)
        return
    end

    if string match -q $HOME $PWD
        echo -n -s '~'
        return
    end

    set -l path_basename (path basename $PWD)
    echo -n -s (_concat_slash_to_dir $path_basename)
end

function _concat_slash_to_dir
    if string match -q '/' $argv
        echo -n -s '/'
        return
    end

    echo -n -s "$argv/"
end


# Building the prompts
#------------------------------------------------------------------------------

function fish_prompt --description 'Write out the prompt'
    # Set the prompt differently when we're root
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        set suffix '#'
    end

    echo -n -s (prompt_login) (set_color normal) $suffix' '
end

function fish_right_prompt --description 'Write out the right prompt'
    # Set the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    if functions -q fish_is_root_user
        and fish_is_root_user
        and set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
    end

    echo -n -s (fish_vcs_prompt) (set_color normal) ' '\
        (set_color $color_cwd) (prompt_pwd) (set_color normal)
end


# Runtime customizability
#------------------------------------------------------------------------------

# Dynamic prompt
begin
    function enable_detailed_prompt
        set -U use_detailed_prompt
    end

    function disable_detailed_prompt --on-event fish_exit
        set -U -e use_detailed_prompt
    end

    function toggle_detailed_prompt
        if not set -q use_detailed_prompt
            enable_detailed_prompt
        else
            disable_detailed_prompt
        end

        commandline -f repaint
    end

    bind f4 toggle_detailed_prompt
end
