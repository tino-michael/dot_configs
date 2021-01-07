filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Update polybar when config is updated.
autocmd BufWritePost *polybar/config !pkill -USR1 polybar

" Update mpd when config is updated.
autocmd BufWritePost *mpd.conf !pkill -15 mpd && mpd
