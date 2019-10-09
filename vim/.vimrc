" FIXME: put all this in .vim folder and import them on a per-file basis

" Basic configuraion {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't try to be compatible with Vi
set nocompatible
" Use UTF-8
set encoding=utf-8
set fileencodings=utf-8

" Allow unsaved buffers when switching windows
set hidden

" Allow command completion in command-line
set wildmenu

" Enable syntax high-lighting and file-type specific plugins
syntax on
filetype plugin indent on
" }}}

" Indentation configuration {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use space by default
set expandtab
" Indent and align to 4 spaces by default
set shiftwidth=4
" -1 means the same as shitwidth
set softtabstop=-1
" Always indent by multiples of shiftwidth
set shiftround
" You shouldn't change the default tab width of 8 characters
set tabstop=8
" Makefiles should use tabs to indent
autocmd Filetype make setlocal noexpandtab
" }}}

" Plugins {{{
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

" Theming {{{
"""""""""
" Nice dark theme
Plug 'nanotech/jellybeans.vim'
" Another nice dark theme
Plug 'morhetz/gruvbox'
" Fancy status bar
Plug 'itchyny/lightline.vim'
" Add the gruvbox theme to my status line
Plug 'shinchu/lightline-gruvbox.vim'
" }}}

" Minimum viable vim config {{{
"""""""""""""""""""""""""""
" Basic default vimrc file
Plug 'tpope/vim-sensible'
" High-light trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" }}}

" Program specific plug-ins {{{
"""""""""""""""""""""""""""
" Pandoc syntax file
Plug 'vim-pandoc/vim-pandoc-syntax'
" Pandoc commands
Plug 'vim-pandoc/vim-pandoc'
" A sane git syntax file
Plug 'tpope/vim-git'
" An awesome git wrapper
Plug 'tpope/vim-fugitive'
" Fuzzy file finder (installs zfz system-wide)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Pre-written functions for fzf mappings
Plug 'junegunn/fzf.vim'
" }}}

" Vim facilities enhancement {{{
""""""""""""""""""""""""""""
" Relative numbers only on focused buffer
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" A better netrw
Plug 'tpope/vim-vinegar'
" Better quick-fix window
Plug 'romainl/vim-qf'
" }}}

" Mappings {{{
""""""""""
" Easily delete, change and add surroundings in pairs
Plug 'tpope/vim-surround'
" Better repeatability with the '.' key
Plug 'tpope/vim-repeat'
" Some ex command mappings
Plug 'tpope/vim-unimpaired'
" }}}

" Snippets {{{
""""""""""
" Snippet manager
Plug 'SirVer/ultisnips'
" Snippet files for Ulti Snips
Plug 'honza/vim-snippets'
" }}}

" Rust {{{
""""""
Plug 'rust-lang/rust.vim'
" }}}
"
" LSP {{{
"""""
" Asynchronous Linting Engine
Plug 'dense-analysis/ale'
" Pre-made ALE integration with lightline
Plug 'maximbaz/lightline-ale'
" }}}

call plug#end()
" }}}

" File parameters {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable backups, we have source control for that
set nobackup
" Disable swapfiles too
set noswapfile
" Don't show Netrw buffers
autocmd FileType netrw setlocal bufhidden=delete
" }}}

" UI and UX parameters {{{
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
" Use the visual bell instead of beeping
set visualbell
" Disable bell completely by resetting the visual bell's escape sequence
set t_vb=

" Color the 80th column
set colorcolumn=80
" Show whitespace
set list
" Show a tab as an arrow, and spaces as dots
set listchars=tab:»·,trail:·

" Timeout quickly on shortcuts, I can't wait two seconds to delete in visual
set timeoutlen=500
" }}}

" Search parameters {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable search high-lighting while the search is on-going
set hlsearch
" Ignore case on search
set ignorecase
" Ignore case unless there is an uppercase letter in the pattern
set smartcase
" }}}

" Plugin parameters {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BetterWhitespace settings {{{
"""""""""""""""""""""""""""
" Enable trailing whitespace high-lighting
let g:better_whitespace_enabled=1
" Strip trailing whitespace on file-save
let g:strip_whitespace_on_save=1
" }}}

" Theme settings {{{
""""""""""""""""
" Use a slightly darker background color to differentiate with the status line
let g:jellybeans_background_color_256='232'
" colorscheme jellybeans
" colorscheme jellybeans

" Set dark mode by default
set background=dark
let g:gruvbox_contrast_dark='(hard)'
" Enable italics because urxvt supports them
let g:gruvbox_italic=1
colorscheme gruvbox
" }}}

" Lightline settings {{{
""""""""""""""""""""
let g:lightline={}
" Use the gruvbox colorscheme
let g:lightline.colorscheme='wombat'
let g:lightline.active={
  \     'left': [
  \         [ 'mode', 'paste' ],
  \         [ 'gitbranch', 'readonly', 'filename', 'modified' ],
  \         [ 'spell' ],
  \     ],
  \     'right': [
  \         [ 'lineinfo' ],
  \         [ 'percent' ],
  \         [ 'fileformat', 'fileencoding', 'filetype' ],
  \         [ 'linter_check', 'linter_errors', 'linter_warn', 'linter_ok' ],
  \         [ 'ctags_status' ],
  \     ]
  \ }
let g:lightline.inactive={
  \     'left': [
  \         [ 'filename' ],
  \     ],
  \     'right': [
  \         [ 'lineinfo' ],
  \         [ 'percent' ],
  \     ],
  \ }
let g:lightline.component_function={
  \     'readonly': 'LightlineReadonly',
  \     'modified': 'LightlineModified',
  \     'gitbranch': 'LightlineFugitive',
  \ }
let g:lightline.component_expand={
  \    'linter_check': 'lightline#ale#checking',
  \    'linter_warn': 'lightline#ale#warnings',
  \    'linter_errors': 'lightline#ale#errors',
  \    'linter_ok': 'lightline#ale#ok',
  \ }
let g:lightline.component_type={
  \   'readonly': 'error',
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \ }
" Show pretty icons instead of text for linting status
let g:lightline#ale#indicator_checking='⏳'
let g:lightline#ale#indicator_warnings='◆'
let g:lightline#ale#indicator_errors='✗'
let g:lightline#ale#indicator_ok='✓'

" Lightline function wrappers {{{
"""""""""""""""""""""""""""""
" Show a lock icon when editing a read-only file when it makes sense
function! LightlineReadonly()
    return &ft!~?'help\|vimfiler\|netrw' && &readonly ? '' : ''
endfunction
" Show a '+' when the buffer is modified, '-' if not, when it makes sense
function! LightlineModified()
    return &ft=~'help\|vimfiler\|netrw' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
" Show branch name with nice icon in status line, when it makes sense
function! LightlineFugitive()
    if &ft!~?'help\|vimfiler\|netrw' && exists('*fugitive#head')
            let branch=fugitive#head()
            return branch!=#'' ? ' '.branch : ''
    endif
    return ''
endfunction
" }}}
" }}}

" UltiSnips settings {{{
""""""""""""""""""""
" Insert mode trigger for expansion
let g:UltiSnipsExpandTrigger="<Tab>"
" Jump forward and backwards in place-holder list with Ctrl-f and Ctrl-b
let g:UltiSnipsJumpBackwardTrigger="<C-f>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
" Split the windowd vertically when callin :UltiSnipsEdits
let g:UltiSnipsEditSplit="vertical"
" }}}

" ALE settings {{{
""""""""""""""
" Always display the sign column to avoid moving the buffer all the time
let g:ale_sign_column_always=1
" Change the way ALE display messages
let g:ale_echo_msg_info_str='I'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_error_str='E'
" The message displayed in the command line area
let g:ale_echo_msg_format='[%linter%][%severity%]%(code):% %s'
" The message displayed in the location list
let g:ale_loclist_msg_format='[%linter%]%(code):% %s'

" C/C++ settings {{{
""""""""""""""""
" More warnings and the usual version in flags for Clang
let g:ale_c_clang_options='-Wall -Wextra -pedantic -std=c99'
let g:ale_cpp_clang_options='-Wall -Wextra -pedantic -std=c++17'
" More warnings and the usual version in flags for GCC
let g:ale_c_gcc_options='-Wall -Wextra -pedantic -std=c99'
let g:ale_cpp_gcc_options='-Wall -Wextra -pedantic -std=c++17'
" }}}
" }}}
" }}}

" Mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous mappings {{{
""""""""""""""""""""""""
" Yank until the end of line with Y, to be more consistent with D and C
nnoremap Y y$

" Map leader to space (needs the noremap trick)
nnoremap <Space> <Nop>
let mapleader=" "
" Map localleader to '!' (if I want to filter text, I use visual mode)
let maplocalleader="!"

" Mappings for working with this file.
map <Leader>ev :edit $MYVIMRC<CR>
map <Leader>es :source $MYVIMRC<CR>

" Run make silently, then skip the 'Press ENTER to continue'
noremap <Leader>m :silent! :make! \| :redraw!<CR>
" }}}

" Mapping for quickfix bindings {{{
"""""""""""""""""""""""""""""""
" Next and previous in quick-fix list
nmap <Leader>fn <Plug>(qf_qf_next)
nmap <Leader>fp <Plug>(qf_qf_previous)
" Next and previous in location list
nmap <Leader>ln <Plug>(qf_loc_next)
nmap <Leader>lp <Plug>(qf_loc_previous)
" Toggle quick-fix and location lists
nmap <Leader>tf <Plug>(qf_qf_toggle)
nmap <Leader>tl <Plug>(qf_loc_toggle)
" }}}

" Fuzzy file finder bindings {{{
""""""""""""""""""""""""""""
" Only git-tracked files, Vim needs to be in a Git repository
nmap <Leader>fg :GFiles<CR>
" All files
nmap <Leader>ff :Files<CR>
" Currently open buffers
nmap <Leader>fb :Buffers<CR>
" Buffer history
nmap <Leader>fh :History<CR>
" Tags in buffer
nmap <Leader>ft :BTags<CR>
" Tags in all project files
nmap <Leader>fT :Tags<CR>
" }}}

" Git and diff mappings {{{
"""""""""""""""""""""""
" Visual bindings for merging diffs as in normal mode
xnoremap dp :diffput<cr>
xnoremap do :diffget<cr>
" Git add current file
nnoremap <Leader>ga :Git add %:p<CR><CR>
" Open status window
nnoremap <Leader>gs :Gstatus<CR>
" Open diff view of current buffer: the up/left window is the current index
nnoremap <Leader>gd :Gdiffsplit!<CR>
" Open current file log in new tab, populate its location list with history
nnoremap <Leader>gl :sp<CR><C-w>T:Gllog --follow -- %:p<CR>
" Use git-mv and rename the buffer, backspace and add '!' to use the '-f' flag
nnoremap <Leader>gm :Gmove<Space>
" Open a buffer to the left with blame information
nnoremap <Leader>gb :Gblame<CR>
" Commit staged changes, open a new tab just for it
nnoremap <Leader>gc :Gcommit -v -q<CR>
" Invoke git-push with arguments, populate quick-fix list
nnoremap <Leader>gpu :Gpush<Space>
" Invoke git-pull with arguments, populate quick-fix list
nnoremap <Leader>gpl :Gpull<Space>
" Invoke git-merge with arguments, populate quick-fix list
nnoremap <Leader>gm :Gmerge<Space>
" }}}
" }}}

" Import settings when inside a git repository {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let git_settings=system("git config --get vim.settings")
if strlen(git_settings)
    exe "set" git_settings
endif
" }}}

" vim: foldmethod=marker
