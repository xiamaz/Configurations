call plug#begin()
"" Neovim configuration
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
"" Vim Utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
"" make marks usabe
Plug 'kshenoy/vim-signature'

"" Vim Airline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
"" Whitespace Plugins
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
"" Theme plugins
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
"" Linting engine
Plug 'w0rp/ale' " deps: pylint, flake8
"" Git tools
"" Javascript plugins
Plug 'elmcast/elm-vim', {'for' : 'elm'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
"" Fish script highlighting plugin
Plug 'kballard/vim-fish', {'for' : 'fish'}
"" QML Syntax file
Plug 'peterhoeg/vim-qml', {'for' : 'qml'}
"" Vim easy align
Plug 'junegunn/vim-easy-align'
"" Tags
Plug 'majutsushi/tagbar'   " deps: universal-ctags
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
" go source
Plug 'fatih/vim-go', {'for': 'go'}
"" ---------------------
" python repl
Plug 'jalvesaq/vimcmdline', {'for': 'python'}
" Python plugins
Plug 'Vimjas/vim-python-pep8-indent', {'for' : 'python'}
Plug 'tell-k/vim-autopep8', {'for' : 'python'}
" rst plugin
Plug 'Rykka/riv.vim', {'for': 'rst'}
Plug 'Rykka/InstantRst', {'for': 'rst'}
" latex plugin
Plug 'lervag/vimtex', {'for': 'tex'}
" dockerfile plugin
Plug 'ekalinin/Dockerfile.vim'
" Webdev plugins
Plug 'Valloric/MatchTagAlways', {'for' : 'html'}
Plug 'mattn/emmet-vim', {'for': 'html'}
" tag file management
Plug 'ludovicchabant/vim-gutentags'
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

"" Plugin Configuration
" Lightline
let g:lightline = {
      \  'colorscheme': 'Tomorrow_Night',
      \  'component': {
      \    'charvaluehex': '0x%B',
      \  },
      \  'component_expand': {
      \    'linter_checking': 'lightline#ale#checking',
      \    'linter_warnings': 'lightline#ale#warnings',
      \    'linter_errors': 'lightline#ale#errors',
      \    'linter_ok': 'lightline#ale#ok',
      \  },
      \  'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \  },
      \  'active': {
      \     'right': [
      \        [ 'lineinfo' ],
      \        [ 'percent' ],
      \        [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
      \        ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
      \     ]
      \  },
      \}
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
nmap <F7> :TagbarToggle<CR>
let g:tagbar_left = 1
" nvim completion manager settings
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" vimcmdline settings
let cmdline_app = {'python': 'ipython3'}
let cmdline_map_start          = '<LocalLeader>rf'
let cmdline_map_send           = '<LocalLeader>l'
let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
let cmdline_map_source_fun     = '<LocalLeader>f'
let cmdline_map_send_paragraph = '<LocalLeader>p'
let cmdline_map_send_block     = '<LocalLeader>b'
let cmdline_map_quit           = '<LocalLeader>rq'
let cmdline_vsplit = 1
let cmdline_term_width = 80
"vim riv rst editor
let g:riv_disable_folding = 1
" instantRst
let g:instant_rst_browser = 'firefox'

" Ale linting settings
let g:ale_r_lintr_options = 'with_defaults(object_name_linter = NULL, line_length_linter(120), closed_curly_linter = NULL, open_curly_linter = NULL, snake_case_linter = NULL, camel_case_linter = NULL, multiple_dots_linter = NULL)'
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %code%:%s [%severity%]'
let g:ale_linters = {'python': ['flake8', 'pylint']}

" latex settings
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
let g:tex_conceal = "admgs"

" other python keybinds
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" keybindings for window switching
tnoremap <Esc> <C-\><C-n>

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
