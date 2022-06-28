let mapleader =" "

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins List
call plug#begin(stdpath('data') . '/plugged')

" UI related
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" color scheme
Plug 'dracula/vim', { 'as': 'dracula' }
" File browsing panel
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

" comment toggler
Plug 'preservim/nerdcommenter'
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" file finder
Plug 'ctrlpvim/ctrlp.vim'

" syntax check
Plug 'w0rp/ale'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Formater
Plug 'Chiel92/vim-autoformat'

" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'
" VCS indicators
Plug 'mhinz/vim-signify'

" Latex plugins
Plug 'lervag/vimtex'
Plug 'gi1242/vim-tex-syntax'

" Markdown plugins
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
" sass css syntax
Plug 'cakebaker/scss-syntax.vim'
" highlight colour names and variables
Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,sass,scss,html,text'

" csv helper
Plug 'chrisbra/csv.vim'
" Initialize plugin system
call plug#end()


" some basics:
filetype plugin indent on
set encoding=utf-8
syntax on
syntax enable

colorscheme dracula

" spell-checking certain file types (turn on locally with `:setlocal spell`)
autocmd BufRead,BufNewFile *.md,*.tex,*.txt setlocal spell
set spelllang=en_us,de_de,en_gb,fr
set complete+=kspell
map <leader>s :setlocal spell!<CR>

" show existing tab with 4 spaces width
set tabstop=4
" number of spaces to use for indent
set shiftwidth=4
" pressing tab inserts spaces
set expandtab

" copy indent from current line when starting a new line
set autoindent

" Set the terminal title to the current file
set title
" Highlight the line under the cursor
set cursorline

" wrap line on word boundaries
set linebreak

" enable folding
set foldmethod=indent
set foldlevel=99
nmap <c-f> za

" shows line numbers
set number relativenumber
set nocompatible
set hidden

" highlight columns 100 and 120 as vertical ruler
let &colorcolumn="100,120"
highlight ColorColumn ctermbg=1

" don't beep
set visualbell
set noerrorbells

" detect changes to file outside of vim and read in changes
set autoread
" autosave buffers on focus loss
autocmd BufLeave,FocusLost * silent! wall


" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase


" Disables automatic commenting on newline:
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable autocomplete
set wildmenu
set wildmode=longest:full,full

" split below and to right by default
set splitbelow
set splitright

" equalise widths and heights of all panes
nnoremap <leader>f <C-W>=

" testing rounded separators (extra-powerline-symbols):
let g:airline_left_sep = "\uE0B4"
let g:airline_right_sep = "\uE0B6"

" set the CN (column number) symbol:
let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

" vimtex Latex settings
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_compiler_progname = 'nvr'
noremap <A-l> :VimtexCompile<CR>

" fuzzy file finding with CtrlP and ripgrep
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
" set starting directory to
" (r) the nearest ancestor of the current file that contains one of these directories or files: .git .hg .svn .bzr _darcs
" (a) the directory of the current file, unless it is a subdirectory of the cwd
let g:ctrlp_working_path_mode = 'ra'
" additional root directory markers
let g:ctrlp_root_markers = ['.tasks']
" use rg as file search command
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif


" clear search string
noremap <silent> <C-l> :let @/ = ""<CR>

" yank to and paste from system clipboard
nnoremap <C-y> <S-v> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+p
inoremap <C-p> <esc> "+P i

" Nerdtree
" toggles Nerdtree open/closed
noremap <silent> <leader>b :NERDTreeToggle<CR>
" finds the current file in Nerdtree (puts cursor over it); opens Nerdtree if necessary
noremap <M-b> :NERDTreeFind<CR>
let g:NERDTreeIgnore = ['__pycache__', '\.egg-info']
" Exit vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" show bookmars on startup
let NERDTreeShowBookmarks=1


" indent with tab in normal mode
nnoremap <tab> >>
nnoremap <s-tab> <<

" split buffer navigation
nnoremap <Leader>e <C-W><C-L>
nnoremap <Leader>i <C-W><C-H>
nnoremap <Leader>a <C-W><C-J>
nnoremap <Leader>l <C-W><C-K>

" go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <leader>t :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <leader>t :exe "tabn ".g:lasttab<cr>

" go to last active buffer
nnoremap <c-x> :bprevious<CR>

" move lines up / down
nnoremap <S-A-r> :m .+1<CR>==
nnoremap <S-A-n> :m .-2<CR>==
inoremap <S-A-r> <Esc>:m .+1<CR>==gi
inoremap <S-A-n> <Esc>:m .-2<CR>==gi
vnoremap <S-A-r> :m '>+1<CR>gv=gv
vnoremap <S-A-n> :m '<-2<CR>gv=gv

" auto arranges specific csv files
aug CSV_Editing
    au!

    let b:csv_arrange_align = 'lrr.r'

    au BufRead,BufWritePost */wheel/*.csv :%ArrangeColumn
    au BufWritePre */wheel/*.csv :%UnArrangeColumn
    au BufRead,BufWritePost */dividends/*.csv,*.csv :%ArrangeColumn
    au BufWritePre */dividends/*.csv,*.csv :%UnArrangeColumn
aug end

" auto delete trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" clear latex auxiliary files when leaving a .tex file
autocmd VimLeave *.tex !texclear %


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Config updates (restart a program or make it reload its config when needed)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup config_updates
    autocmd!

    " Update polybar when config is updated.
    autocmd BufWritePost */polybar/config !pkill -USR1 polybar

    " Update mpd when config is updated.
    autocmd BufWritePost *mpd.conf !pkill -15 mpd && mpd

    autocmd BufWritePost */alacritty.yml.in,*/dunstrc.in !generate_xresource_configs

    " reread xresources when config is updated
    autocmd BufWritePost xresources !xrdb %

augroup END
