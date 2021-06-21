syntax enable

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'cohama/agit.vim'
  Plug 'editorconfig/editorconfig-vim'

  Plug 'airblade/vim-rooter'

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-project.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'leafgarland/typescript-vim'
  Plug 'mattn/emmet-vim'
  Plug 'jelera/vim-javascript-syntax'
  Plug 'posva/vim-vue'
  Plug 'prettier/vim-prettier'
  Plug 'rust-lang/rust.vim'
  Plug 'alvan/vim-closetag'
  Plug 'cespare/vim-toml' 

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'

  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  Plug 'itchyny/lightline.vim'
  Plug 'josa42/vim-lightline-coc'
  Plug 'shinchu/lightline-gruvbox.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""
" general config 
"""""""""""""""""""""""""""""""""""
filetype on
filetype plugin indent on

set hidden
set termguicolors
set cscopeverbose
set cscopetag
set tabstop=2
set shiftwidth=2
"set softtabstop
set expandtab
set ignorecase
set smartcase
set autoindent
set smartindent
set cindent
set backspace=indent,eol,start
set nobackup
set nowritebackup
set noundofile
set scrolloff=10
set number relativenumber
set numberwidth=6
set mouse=a
set clipboard+=unnamedplus
set path+=** " search down into subfolders (for tab-complete)
set wildmenu " display all matching files for tab-complete
set wrap!
" set autochdir
set updatetime=300
set shortmess+=c
set splitbelow
set splitright

set wildignore+=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js
set wildignore+=*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wildignore+=**/node_modules/**

" set t_Co=256
" set showmatch
set belloff=all

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/
nnoremap ; :

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

set inccommand=nosplit

"""""""""""""""""""""""""""""""""""
" global variables
"""""""""""""""""""""""""""""""""""
let g:explore_is_open = 0
let g:netrw_keepdir = 0
let g:netrw_preview = 1
let g:netrw_alto = 0
let g:netrw_liststyle = 0
let g:netrw_winsize   = 30

"""""""""""""""""""""""""""""""""""
" functions 
"""""""""""""""""""""""""""""""""""
function! ToggleExplore()
    if g:explore_is_open  
		let g:explore_is_open = 0
		:Rexplore
    else
		let g:explore_is_open = 1
		:Explore
    endif
endfunction

" highlighting and color
"""""""""""""""""""""""""""""""""""
" au Syntax c	source $VIMRUNTIME/syntax/c.vim
" au Syntax cpp source $VIMRUNTIME/syntax/c.vim

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=600}
augroup END

nnoremap n nzz
nnoremap N Nzz
nnoremap <silent><expr> <C-h> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

set t_Co=256   " This is may or may not needed.

" light colorscheme
set background=dark
" colorscheme peachpuff
" colorscheme solarized8
colorscheme gruvbox

" dark colorscheme
" set background=dark
" colorscheme embark
"
" colorscheme seoul256-light
" colorscheme PaperColor
" colorscheme ayu
" colorscheme apprentice
" colorscheme simple-dark
"
set cursorline
hi Normal guibg=NONE ctermbg=NONE

set tags=./.tags;/

"""""""""""""""""""""""""""""""""""
" keyboard remappings
"""""""""""""""""""""""""""""""""""
" preview tag/ close preview tags

" save file
inoremap <C-H> <C-W>
set backspace=indent,eol,start

" Simulate the "normal" behavior of ctrl [right|left] in emacs/vscode/browsers
imap <C-Right> <S-Right>
imap <C-Left> <S-Left>
nmap <C-Right> <S-Right>
nmap <C-Left> <S-Left>

" Jump in blocks using Ctrl up and down
nmap <C-Up> <S-{>
nmap <C-Down> <S-}>
vmap <C-Up> <S-{>
vmap <C-Down> <S-}>

let mapleader = " "
noremap <silent> <leader>g :tab G<CR>
" Open this config file
noremap <silent> <leader>i :e ~/.config/nvim/init.vim<CR>

" show/hide explorer window
noremap <silent> <C-e> :call ToggleExplore()<CR>

lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", "scratch/.*", "%.env" },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-u', -- thats the new thing
      '--hidden',
    },
  }
}
EOF
" Find files using Telescope command-line sugar.
nnoremap <leader><leader> :lua require('telescope.builtin').buffers{ show_all_buffers = true, sort_lastused = true}<CR>
nnoremap <silent><C-p> <cmd>Telescope git_files<CR>
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>pp <cmd>:lua require'telescope'.load_extension('project')<CR>

nnoremap <PageUp> :tabn<CR>
nnoremap <PageDown> :tabp<CR>

" Vim fugitive
nnoremap <F4> :tabclose<CR>
inoremap <C-c> <esc>

if executable('rg')
  let g:rg_derive_root='true'
endif

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'

"""""""""""""""""""""""""""""""""""
" vim-go
"""""""""""""""""""""""""""""""""""
" let g:go_auto_type_info = 1
" let g:go_diagnostic_level = 2
" let g:go_highlight_diagnostic_errors = 1
" let g:go_highlight_diagnostic_warnings = 1
" let g:go_gopls_enabled = 0

"""""""""""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""""""""""
let g:coc_node_path = '/usr/bin/node'
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-vetur', 'coc-tsserver']

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent><F12> <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
" Symbol renaming.
nmap <silent><F2> <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Quickfix
noremap <silent><C-q> :copen <CR>
noremap <leader>qn :cn <CR>
noremap <leader>qp :cp <CR>

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:vim_markdown_folding_disabled = 1

set laststatus=2
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ],
      \             [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }

" register compoments:
call lightline#coc#register()

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
au FileType gitcommit let b:EditorConfig_disable = 1

