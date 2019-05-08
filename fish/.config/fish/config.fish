# SET ENVIRONMENT VARIABLES


## set preferred editors
set -gx EDITOR nvim
set -gx VISUAL subl
set -gx PAGER less


## xdg directories
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache


## fixes to use XDG structure
set -gx PIP_CONFIG_FILE $XDG_CONFIG_HOME/pip/pip.conf
set -gx PYLINTHOME $XDG_CACHE_HOME/pylint
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx NPM_CONFIG_PREFIX $XDG_DATA_HOME/npm
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx LESSHISTFILE $XDG_DATA_HOME/less/history
set -gx GOPATH $XDG_DATA_HOME/go
set -gx GOCACHE $XDG_CACHE_HOME/go
set -gx GEM_HOME $XDG_DATA_HOME/gem
set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
set -gx GEMRC $XDG_CONFIG_HOME/gem/gemrc
set -gx _JAVA_OPTIONS Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
set -gx WGETRC $XDG_CONFIG_HOME/wget/wgetrc
# set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
# set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
# set -gx RBENV_ROOT $XDG_DATA_HOME/rbenv
# set -gx STACK_ROOT $XDG_DATA_HOME/stack


## options for fisher
set -g fisher_path $HOME/.config/fish/fisher
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end


## options for fzf

### all
set -g FZF_DEFAULT_OPTS "--height 60% --reverse --border"

### legacy shipped with fzf
#set -g FZF_DEFAULT_COMMAND "fd --type f"
#set -g FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
#set -g FZF_ALT_C_COMMAND "fd --type d"

### using fisher installed fzf bindings
set -g FZF_FIND_FILE_COMMAND "fd --type f . \$dir"
set -g FZF_CD_COMMAND "fd --type d . \$dir"
set -g FZF_CD_WITH_HIDDEN_COMMAND "fd --type d --hidden . \$dir"
set -g FZF_OPEN_COMMAND "fd --type d --type f --hidden . \$dir"
set -g FZF_PREVIEW_FILE_CMD "head -n 5"
set -g FZF_PREVIEW_DIR_CMD "l"

## options for less pager
set -gx LESS "-F -g -i -M -R -S -w -X -z-4"

if command -sq pygmentize
    set -gx LESSCOLORIZER pygmentize
end

if command -sq lesspipe.sh
    set -gx LESSOPEN "|/usr/bin/lesspipe.sh %s"
    set -gx LESS_ADVANCED_PREPROCESSOR 1
end

set -gx LESS_TERMCAP_mb (set_color red)  # begin bold
set -gx LESS_TERMCAP_md (set_color -o blue)  # begin blink
set -gx LESS_TERMCAP_me (set_color normal)  # reset bold/blink
set -gx LESS_TERMCAP_so (set_color -o black; set_color -b brwhite)  # begin reverse video
set -gx LESS_TERMCAP_se (set_color normal)  # reset reverse video
set -gx LESS_TERMCAP_us (set_color -o green)  # begin underline
set -gx LESS_TERMCAP_ue (set_color normal)  # reset underline


## fish color options
source $XDG_CONFIG_HOME/fish/colors.fish


## Spacefish prompt options
set -g SPACEFISH_PROMPT_ORDER time user dir host git exec_time line_sep jobs exit_code char


# SET PATHS

## load defined path into fish_user_paths
set fish_user_paths $CARGO_HOME/bin $GOPATH/bin $NPM_CONFIG_PREFIX/bin $HOME/.local/bin
