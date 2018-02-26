call plug#begin()
"" Neovim configuration
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
"" Vim Surround
Plug 'tpope/vim-surround'
"" Vim Airline
Plug 'vim-airline/vim-airline'
"" Whitespace Plugins
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
"" Theme plugins
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
"" Linting engine
Plug 'w0rp/ale'
"" Javascript plugins
Plug 'elmcast/elm-vim', {'for' : 'elm'}
"" Fish script highlighting plugin
Plug 'kballard/vim-fish', {'for' : 'fish'}
"" QML Syntax file
Plug 'peterhoeg/vim-qml', {'for' : 'qml'}
"" Vim easy align
Plug 'junegunn/vim-easy-align'
"" Tags
Plug 'majutsushi/tagbar'
"" R plugins
Plug 'jalvesaq/Nvim-R', {'for' : 'r'}
" Autocompletion
Plug 'roxma/nvim-completion-manager'
"" NCM Completion sources
" C/C++ Completion source
Plug 'roxma/ncm-clang'
" Elm source
Plug 'roxma/ncm-elm-oracle', {'for' : 'elm'}
" vimscript source
Plug 'Shougo/neco-vim'
" R source
Plug 'gaalcaras/ncm-R', {'for' : 'r'}
"" ---------------------
" Interactive REPL
Plug 'xiamaz/iron.nvim', {'for' : 'python', 'do':':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent', {'for' : 'python'}
call plug#end()

"" Basic Settings
syntax on
let mapleader=","
let maplocalleader = ";"
" undo history persistent after closed file
set undofile
" indentation settings
filetype plugin indent on
set autoindent
" smart tabs configuration - use tabs for indent and spaces for align
set noexpandtab copyindent preserveindent softtabstop=0 shiftwidth=4 tabstop=4
set number
set ignorecase smartcase " only case sensitive when using uppercase
set mouse=a
" setup wordwrap
set wrap linebreak formatoptions-=t breakindent
" no beeping
set vb t_vb=
" split settings
set splitbelow
set splitright
" set textwidth to 80 chars
set textwidth=80
" color background past 80 chars
let &colorcolumn="80,".join(range(120,999),",")
" disable linenumbers in terminal
au TermOpen * setlocal nonu

"" Theme Settings
" set colorscheme for 256-color supported terminals
set termguicolors
colorscheme base16-tomorrow-night
set background=dark
let g:airline_theme='base16'

"" Plugin Configuration
" Airline
let g:airline#extensions#tabline#enabled = 1
" do not show the insert status, since we already have airline
set noshowmode
" VimWiki and calendar
let g:calendar_monday = 1
" Whitespace - Tabs line Spaces dotted
let g:indentLine_char = '┆'
set list lcs=tab:\│\ 
hi Whitespace ctermfg=19
" Nvim-R disable assign operator keybinding
let R_assign = 0
" Tagbar settings
nmap <F8> :TagbarToggle<CR>
" nvim completion manager settings
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" iron repl settings
let g:iron_repl_open_cmd = 'vsplit'
let g:iron_map_defaults=0
augroup ironmapping
    autocmd!
    autocmd Filetype python nmap <buffer> <localleader>rf :call IronStartCustomRepl('python','ipython','ipython3') <CR><Esc><c-w><c-p>
    autocmd Filetype python nmap <buffer> <localleader>l V<Plug>(iron-send-motion)
    autocmd Filetype python vmap <buffer> <localleader>l <Plug>(iron-send-motion)
    autocmd Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
    autocmd Filetype python nmap <buffer> <localleader>rq :call IronSend("exit\n")<CR>
augroup END
" Ale linting settings
" let g:ale_r_lintr_options = 'with_defaults(object_name_linter = object_name_linter(c("lowerCamelCase", "UpperCamelCase", "dotted.case")))'
let g:ale_r_lintr_options = 'with_defaults(object_name_linter = NULL, line_length_linter(120), closed_curly_linter = NULL, open_curly_linter = NULL)'
" let g:ale_r_lintr_options = 'with_defaults(object_name_linter = object_name_linter(c("lowerCamelCase", "UpperCamelCase", "dotted.case")), object_usage_linter = NULL)'

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" keybindings for window switching
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"" Custom keybindings
" setup arrowkeys for visual scroll
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>
" remove highlight with escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" german remaps for easier movements
nnoremap ö (
vnoremap ö (
xnoremap ö (
snoremap ö (
nnoremap ä )
vnoremap ä )
xnoremap ä )
snoremap ä )
nnoremap Ö {
vnoremap Ö {
xnoremap Ö {
snoremap Ö {
nnoremap Ä }
vnoremap Ä }
xnoremap Ä }
snoremap Ä }
nnoremap ü <C-]>
