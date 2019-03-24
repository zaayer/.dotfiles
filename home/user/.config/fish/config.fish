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
set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
# set -gx RBENV_ROOT $XDG_DATA_HOME/rbenv
# set -gx STACK_ROOT $XDG_DATA_HOME/stack


## options for fzf
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--height 60% --reverse --border"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type d"


## options for bat
set -gx BAT_THEME "Sublime Snazzy"


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


# SET SPACEFISH PROMPT OPTIONS
set -g SPACEFISH_CHAR_SYMBOL "λ" # options: ◆ ⇢ ↳ ↪ λ → ⌘ Default: ➜
set -g SPACEFISH_DIR_TRUNC 0
set -g SPACEFISH_DIR_TRUNC_REPO false
set -g SPACEFISH_DOCKER_SYMBOL " "
set -g SPACEFISH_RUBY_SYMBOL " "
set -g SPACEFISH_HASKELL_SYMBOL " "
set -g SPACEFISH_RUST_SYMBOL " "
set -g SPACEFISH_AWS_SYMBOL " "
set -g SPACEFISH_PYENV_SYMBOL " "
set -g SPACEFISH_GOLANG_SYMBOL "ﳑ "
set -g SPACEFISH_PHP_SYMBOL " "

# SET PATHS

## load defined path into fish_user_paths
set fish_user_paths $CARGO_HOME/bin $GOPATH/bin $NPM_CONFIG_PREFIX/bin
