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

" File browsing panel
Plug 'preservim/nerdtree'
" file finder
Plug 'ctrlpvim/ctrlp.vim'

" syntax check
Plug 'w0rp/ale'

" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'

" Formater
Plug 'Chiel92/vim-autoformat'

" VCS indicators
Plug 'mhinz/vim-signify'

" Latex plugins
Plug 'lervag/vimtex'
Plug 'gi1242/vim-tex-syntax'

" highlight colour names and variables
Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,text'
Plug 'shmargum/vim-sass-colors'

" csv helper
Plug 'chrisbra/csv.vim'
" Initialize plugin system
call plug#end()


" some basics:
filetype plugin indent on
set encoding=utf-8
syntax on
syntax enable

colorscheme tomorrow_night

" spell-checking certain file types (turn on locally with `:setlocal spell`)
autocmd BufRead,BufNewFile *.md,*tex,*txt setlocal spell
set spelllang=en_us,de_de,en_uk,fr_fr
set complete+=kspell
map <leader>s :setlocal spell!<CR>

" show existing tab with 4 spaces width
set tabstop=4
" number of spaces to use for auto indent
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" copy indent from current line when starting a new line
set autoindent

" Set the terminal title to the current file
set title
" Highlight the line under the cursor
set cursorline

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

" vimtex Latex settings
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'

" fuzzy file finding with CtrlP and ripgrep
let g:ctrlp_map = '<c-p>'
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


augroup NCM2
  autocmd!

  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect

  autocmd Filetype tex call ncm2#register_source({
            \ 'name': 'vimtex',
            \ 'priority': 8,
            \ 'scope': ['tex'],
            \ 'mark': 'tex',
            \ 'word_pattern': '\w+',
            \ 'complete_pattern': g:vimtex#re#ncm2,
            \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
            \ })
augroup END


" toggle comments
augroup commenting_blocks_of_code
    autocmd!
    let b:comment_leader = '// '
    autocmd FileType c,cpp,java,scala      let b:comment_leader = '// '
    autocmd FileType sh,ruby,python,perl   let b:comment_leader = '# '
    autocmd FileType conf,fstab            let b:comment_leader = '# '
    autocmd FileType tex                   let b:comment_leader = '% '
    autocmd FileType mail                  let b:comment_leader = '> '
    autocmd FileType vim                   let b:comment_leader = '" '
augroup END
noremap <silent> <Leader>cc :<C-B>silent <C-E>s/^\(\s*\)/\1<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <Leader>cu :<C-B>silent <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/')<CR>/\1/e<CR>:nohlsearch<CR>


" clear search string
noremap <silent> <C-l> :let @/ = ""<CR>


" Nerdtree
noremap <silent> <C-b> :NERDTreeToggle<CR>
noremap <silent> <leader>b :NERDTreeFocus<CR>
map <M-e> :NERDTreeFind<CR>
let g:NERDTreeIgnore = ['__pycache__']
" Exit vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" split buffer navigation
nnoremap <Leader>e <C-W><C-L>
nnoremap <Leader>i <C-W><C-H>
nnoremap <Leader>a <C-W><C-J>
nnoremap <Leader>l <C-W><C-K>



" auto arranges option wheel csv files
aug CSV_Editing
	au!
	au BufRead,BufWritePost */wheel/*.csv :%ArrangeColumn
	au BufWritePre */wheel/*.csv :%UnArrangeColumn
aug end

let b:csv_arrange_align = 'lrr.r'

" auto delete trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e


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
