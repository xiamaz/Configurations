call plug#begin()
"" Neovim configuration
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
"" Vim Utils
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'   " deps: universal-ctags
Plug 'kshenoy/vim-signature'  " show marks in gutter
Plug 'krisajenkins/vim-projectlocal' " put a local vimrc in projects
"" Vim Airline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
"" Whitespace Plugins
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
"" Theme plugins
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'

Plug 'w0rp/ale' " deps: pylint, flake8
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'peterhoeg/vim-qml', {'for' : 'qml'}
Plug 'jalvesaq/Nvim-R', {'for' : 'r'}
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries', 'for': 'go'}
Plug 'keith/swift.vim'
"" Julia support
Plug 'JuliaEditorSupport/julia-vim'
" Autocompletion
Plug 'roxma/nvim-yarp'  " nvim framework
Plug 'ncm2/ncm2'
"" NCM Completion sources
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tern', {'for': 'javascript', 'do': 'yarn install'}
Plug 'ncm2/ncm2-jedi', {'for': 'python'}
Plug 'ncm2/ncm2-pyclang', {'for': 'c'}
Plug 'ncm2/ncm2-vim', {'for': 'vim'}
Plug 'ncm2/ncm2-go', {'for': 'go'}
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Sniplet support
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
"" ---------------------
" python repl
Plug 'jalvesaq/vimcmdline', {'for': 'python'}
" Python plugins
Plug 'Vimjas/vim-python-pep8-indent', {'for' : 'python'}
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
let maplocalleader = ";"
" undo history persistent after closed file
set undofile
" indentation settings
filetype plugin indent on
set autoindent
" smart tabs configuration - use tabs for indent and spaces for align
set noexpandtab copyindent preserveindent softtabstop=0 shiftwidth=4 tabstop=4
set number  " always show linenumbers
set ignorecase smartcase  " search options
set mouse=a
set wrap linebreak formatoptions-=t breakindent  " setup wordwrap
set vb t_vb=  " no beeping
set splitbelow splitright  " split settings
set textwidth=80  " set textwidth to 80 chars
let &colorcolumn="80,".join(range(120,999),",")  " color background past 80 chars
au TermOpen * setlocal nonu  " disable linenumbers in terminal
set hidden  " Hide files instead of close

"" Theme Settings
if $TERM=~'linux'
	set guicursor=
else
    " set colorscheme for 256-color supported terminals
    set termguicolors
    colorscheme base16-tomorrow-night
    set background=dark
end

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
let g:indentLine_setConceal = 0
set list lcs=tab:\│\ 
hi Whitespace ctermfg=19
nnoremap <F6> :ToggleWhitespace<CR>
" Nvim-R disable assign operator keybinding
let R_assign = 0
let R_app = "rtichoke"
let R_cmd = "R"
let R_hl_term = 0
" let R_args = []  " if you had set any
let R_bracketed_paste = 1
" Tagbar settings
nmap <F7> :TagbarToggle<CR>
let g:tagbar_left = 1
" ncm2 completion manager settings
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c  " hide some messages
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" gutentags config
let g:gutentags_exclude_filetypes = ['.txt', '.md', '.rst', '.json', '.xml', '.sh', '.bash']
let g:gutentags_cache_dir = '~/.cache/tags'
let g:gutentags_file_list_command = {
			\ 'markers': {
			\ '.git': 'git ls-files',
			\ '.hg': 'hg files',
			\ },
			\ }

" latex completion using vimtex
au InsertEnter * call ncm2#enable_for_buffer()
au Filetype tex call ncm2#register_source({
			\ 'name' : 'vimtex-cmds',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'prefix', 'key': 'word'},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#cmds,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
au Filetype tex call ncm2#register_source({
			\ 'name' : 'vimtex-labels',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'combine',
			\             'matchers': [
			\               {'name': 'substr', 'key': 'word'},
			\               {'name': 'substr', 'key': 'menu'},
			\             ]},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#labels,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
au Filetype tex call ncm2#register_source({
			\ 'name' : 'vimtex-files',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'combine',
			\             'matchers': [
			\               {'name': 'abbrfuzzy', 'key': 'word'},
			\               {'name': 'abbrfuzzy', 'key': 'abbr'},
			\             ]},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#files,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })
au Filetype tex call ncm2#register_source({
			\ 'name' : 'bibtex',
			\ 'priority': 8,
			\ 'complete_length': -1,
			\ 'scope': ['tex'],
			\ 'matcher': {'name': 'combine',
			\             'matchers': [
			\               {'name': 'prefix', 'key': 'word'},
			\               {'name': 'abbrfuzzy', 'key': 'abbr'},
			\               {'name': 'abbrfuzzy', 'key': 'menu'},
			\             ]},
			\ 'word_pattern': '\w+',
			\ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
			\ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
			\ })

" language server settings
let g:LanguageClient_serverCommands = {
    \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    \     using LanguageServer;
    \     using Pkg;
    \     import StaticLint;
    \     import SymbolServer;
    \     env_path = dirname(Pkg.Types.Context().env.project_file);
    \     server = LanguageServer.LanguageServerInstance(stdin, stdout, false, env_path, "", Dict());
    \     server.runlinter = true;
    \     run(server);
    \ '],
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ }
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>

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
let g:riv_section_levels = '*=-^"'
" instantRst
let g:instant_rst_browser = 'firefox'

" sniplet settings
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit="vertical"

" Ale linting settings
let g:ale_r_lintr_options = 'with_defaults(object_name_linter = NULL, line_length_linter(120), closed_curly_linter = NULL, open_curly_linter = NULL, snake_case_linter = NULL, camel_case_linter = NULL, multiple_dots_linter = NULL)'
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %code%:%s [%severity%]'
let g:ale_linters = {'python': ['flake8', 'pylint']}
let g:ale_python_flake8_options = '--ignore=F821'

" latex settings
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
let g:tex_conceal = ""

" Clipboard settings
set clipboard=unnamedplus

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

nnoremap <Leader>i  mzgg=G`z :retab<CR>
