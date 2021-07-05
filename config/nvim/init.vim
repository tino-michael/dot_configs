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

" Latex plugins
Plug 'lervag/vimtex'
Plug 'gi1242/vim-tex-syntax'

" highlight colour names and variables
Plug 'chrisbra/Colorizer'
let g:colorizer_auto_filetype='css,html,text'
Plug 'shmargum/vim-sass-colors'

" Initialize plugin system
call plug#end()


" some basics:
filetype plugin indent on
set encoding=utf-8
syntax on

colorscheme tomorrow_night

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

" don't beep
set visualbell
set noerrorbells

" detect changes to file outside of vim and read in changes
set autoread


" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

" vimtex Latex settings
let g:tex_flavor  = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 1
let g:vimtex_compiler_progname = 'nvr'


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

    autocmd BufWritePost */alacritty.yml.in !generate_xresource_configs
augroup END
