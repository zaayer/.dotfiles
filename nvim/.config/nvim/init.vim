set rtp+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
    call dein#begin('~/.local/share/dein')

    call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

    " Enable snippets
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')

    " deoplete for code completion and languages added
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('sebastianmarkow/deoplete-rust', {'on_ft': 'rust'}) "Rust
    call dein#add('zchee/deoplete-jedi', {'on_ft': 'python'}) "Python
    call dein#add('zchee/deoplete-go', {'on_ft': 'go'}) "Go
    " call dein#add('eagletmt/neco-ghc') "Haskell
    " call dein#add('landaire/deoplete-swift') "Swift

    " Preferred python formatter
    call dein#add('ambv/black', {'on_ft': 'python'})

    " Syntax highlighting
    call dein#add('rust-lang/rust.vim', {'on_ft': 'rust'})
    call dein#add('tpope/vim-dotenv', {'on_ft': 'sh'})
    call dein#add('stephpy/vim-yaml', {'on_ft': 'yaml'})
    call dein#add('ekalinin/Dockerfile.vim', {'on_ft': 'dockerfile'})
    call dein#add('sheerun/vim-polyglot')

    " Add my favorite colorschemes
    call dein#add('junegunn/seoul256.vim')
    call dein#add('arcticicestudio/nord-vim')
    call dein#add('mhartington/oceanic-next')
    call dein#add('joshdick/onedark.vim')
    call dein#add('chriskempson/base16-vim')
    call dein#add('phanviet/vim-monokai-pro')
    "call dein#add('drewtempelmeyer/palenight.vim')
    call dein#add('KeitaNakamura/neodark.vim')
    call dein#add('tyrannicaltoucan/vim-quantum')
    call dein#add('zaayer/lightline-monokai-pro')

    " Minimal status line
    call dein#add('itchyny/lightline.vim')

    " Add fff as a file manager
    call dein#add('dylanaraps/fff.vim')

    " Git support
    call dein#add('tpope/vim-fugitive')

    " Ability to sudo save with nvim
    call dein#add('lambdalisue/suda.vim')

    " Writing apps for distraction free writing
    call dein#add('junegunn/goyo.vim')
    call dein#add('junegunn/limelight.vim')

    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#end()
    call dein#save_state()
endif

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" Enable filetype plugins
filetype plugin indent on

if &compatible
    set nocompatible
endif

"""""""""""""""""""""""""""""""""""""""""""""""
""" Python Setup
"""""""""""""""""""""""""""""""""""""""""""""""

" Set Black virtualenv
let g:black_virtualenv = '~/.local/share/black'

" Set command to autorun black on Save
autocmd BufWritePost *.py execute ':Black'

" Set variable to run :RustFmt on save
let g:rustfmt_autosave = 1

" Set location of rust programs
let g:deoplete#sources#rust#racer_binary = '$CARGO_HOME/bin/racer'
let g:deoplete#sources#rust#rust_source_path = '$RUSTUP_HOME/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" Set location of python programs
"let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

"""""""""""""""""""""""""""""""""""""""""""""""
""" Colors Setup
"""""""""""""""""""""""""""""""""""""""""""""""

" Enable truecolor
set termguicolors

" Modify the defaults for lightline
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ ['mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ ['lineinfo'],
    \              ['percent'],
    \              [ 'fileencoding', 'filetype'] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" Set the terminal colorscheme

set background=dark

"colorscheme monokai_pro
"let g:lightline.colorscheme = 'monokai_pro'

" GRUVBOX
"let g:gruvbox_italic = 1
"let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
"let g:lightline.colorscheme = 'gruvbox'

" NORD
"let g:nord_italic = 1
"let g:nord_underline = 1
"let g:nord_italic_comments = 1
"let g:nord_cursor_line_number_background = 1
"colorscheme nord
"let g:lightline.colorscheme = 'nord'

" OCEANIC NEXT
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext
"let g:lightline.colorscheme = 'oceanicnext'

"" ONE DARK
"let g:onedark_terminal_italics = 1
"let g:onedark_hide_endofbuffer = 1
"colorscheme onedark
"let g:lightline.colorscheme = 'onedark'

"" SEOUL256
"colorscheme seoul256
"let g:seoul256_background = 235
"let g:lightline.colorscheme = 'seoul256'

" MATERIAL PALE NIGHT
"let g:palenight_terminal_italics = 1
"colorscheme palenight
"let g:lightline.colorscheme = 'palenight'

" NEODARK
"let g:neodark#background = '#262626' "optional
"let g:neodark#use_256color = 0 "0 for true color
"let g:neodark#terminal_transparent = 1 "1 means use terminal background
"let g:neodark#solid_vertsplit = 1 "1 to get solid vertical split matching status line
"colorscheme neodark
"let g:lightline.colorscheme = 'neodark'

" QUANTUM
"let g:quantum_black = 1 "0 for standard quantum
"let g:quantum_italics = 1
"colorscheme quantum
"let g:lightline.colorscheme = 'quantum'

" BASE 16 VIM
" Enable italic comments in base16 themes
let base16colorspace=256
colorscheme base16-eighties
let g:lightline.colorscheme = 'Tomorrow_Night_Eighties'

" Enable syntax highlighting
syntax enable

" Remove the default mode status line because using lightline
set noshowmode


"""""""""""""""""""""""""""""""""""""""""""""""
""" General Setup
"""""""""""""""""""""""""""""""""""""""""""""""

" Add VimLeave autocommand to reset cursor style
au VimLeave * set guicursor=a:block-blinkon1

" Set utf8 as the standard encoding and en_US as language
set encoding=utf8

" Highlight the line where the cursor is located
set cursorline

" Spaces for tabs and a tab is 4 spaces
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Set length of history
set history=500

" Set to autoread when file is changed externally
set autoread

" Turn off backup
set nobackup
set nowb
set noswapfile

" Set auto indent and smart indent
set ai
set si

" Disable modelines
set modelines=0
set nomodeline

" Use a map leader to do extra key commands
let mapleader = ","

" save with <leader>w
nnoremap <leader>w :w!<cr>

" quit all with <leader>q
nnoremap <leader>q :qa!<cr>

" Start fff using <leader>f
nnoremap <leader>f :F<cr>

" Start Goyo with <leader>g
nnoremap <leader>g :Goyo<cr>

" use :W to sudo save the file
command! W w suda://%

" use <C-p> to call FZF
nnoremap <C-p> :<C-u>FZF<cr>

" Auto use limelight with goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
