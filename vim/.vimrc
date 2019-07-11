" FIXME: put all this in .vim folder and import them on a per-file basis

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic configuraion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't try to be compatible with Vi
set nocompatible
" Use UTF-8
set encoding=utf-8 fileencodings=utf-8

" Use space by default
set expandtab
" Indent and align to 4 spaces by default
set shiftwidth=4
" -1 means the same as shitwidth
set softtabstop=-1
" You shouldn't change the default tab width of 8 characters
set tabstop=8
" Makefiles should use tabs to indent
autocmd Filetype make setlocal noexpandtab

" Enable search high-lighting while the search is on-going
set hlsearch
" Color the 80th column
set colorcolumn=80
" Show whitespace
set list listchars=tab:»·,trail:·

" Enable syntax high-lighting
syntax on
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install with :PlugInstall

" FIXME: At some point I'll need to switch over to the native Vim 8.0 package
" feature. Either via manual git subtree management, or maybe through minpac?
"
" Install vim-plug if we don't already have it
" Credit to github.com/captbaritone
if empty(glob("~/.vim/autoload/plug.vim"))
    " Ensure all needed directories exist  (Thanks @kapadiamush)
    execute '!mkdir -p ~/.vim/plugged'
    execute '!mkdir -p ~/.vim/autoload'
    " Download the actual plugin manager
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Theming
"""""""""
" Nice dark theme
Plug 'nanotech/jellybeans.vim'
" Another nice dark theme
Plug 'morhetz/gruvbox'
" Fancy status bar
Plug 'vim-airline/vim-airline'
" Themes for airline
Plug 'vim-airline/vim-airline-themes'

" Minimum viable vim config
"""""""""""""""""""""""""""
" Basic default vimrc file
Plug 'tpope/vim-sensible'
" High-light trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" Program specific plug-ins
"""""""""""""""""""""""""""
" Pandoc syntax file
Plug 'vim-pandoc/vim-pandoc-syntax'
" Pandoc commands
Plug 'vim-pandoc/vim-pandoc'
" A sane git syntax file
Plug 'tpope/vim-git'
" An awesome git wrapper
Plug 'tpope/vim-fugitive'
" Tag management
Plug 'ludovicchabant/vim-gutentags'

" Vim facilities enhancement
""""""""""""""""""""""""""""
" Relative numbers only on focused buffer
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" A better netrw
Plug 'tpope/vim-vinegar'
" Better quick-fix window
Plug 'romainl/vim-qf'

" Mappings
""""""""""
" Easily delete, change and add surroundings in pairs
Plug 'tpope/vim-surround'
" Better repeatability with the '.' key
Plug 'tpope/vim-repeat'
" Some ex command mappings
Plug 'tpope/vim-unimpaired'

" Snippet manager
Plug 'SirVer/ultisnips'
" Snippet files for Ulti Snips
Plug 'honza/vim-snippets'

call plug#end()
-
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File parameters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable backups, we have source control for that
set nobackup
" Disable swapfiles too
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI and UX parameters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the minimal amount of lignes under and above the cursor for context
set scrolloff=5
" Show line number (needed for number toggle)
set number
" Always show status line
set laststatus=2
" Enable Doxygen highlighting
let g:load_doxygen_syntax=1

" Make backspace behave as expected
set backspace=eol,indent,start
" Disable bell completely
set visualbell
set t_vb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yank until the end of line with Y, to be more consistent with D and C
nnoremap Y y$

" Map leader to space (needs the noremap trick)
nnoremap <Space> <nop>
let mapleader=" "

" Run make silently, then skip the 'Press ENTER to continue'
noremap <leader>m :silent! :make! \| :redraw!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search parameters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case on search
set ignorecase
" Ignore case unless there is an uppercase letter in the pattern
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin parameters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable trailing whitespace high-lighting
let g:better_whitespace_enabled=1
" Strip trailing whitespace on file-save
let g:strip_whitespace_on_save=1

" Enable gutentags
let g:gutentags_enabled=1

" Use a slightly darker background color to differentiate with the status line
let g:jellybeans_background_color_256='232'
" colorscheme jellybeans

" Set dark mode by default
set background=dark
let g:gruvbox_contrast_dark = '(hard)'
" Enable italics because urxvt supports them
let g:gruvbox_italic=1
colorscheme gruvbox

" Remap '[' and ']' for vim-unimpaired
nmap < [
nmap > ]
omap < [
omap > ]
xmap < [
xmap > ]

" FIXME: missing UltiSnips configuration

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Import settings when inside a git repository
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let git_settings = system("git config --get vim.settings")
if strlen(git_settings)
	exe "set" git_settings
endif
