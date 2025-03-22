call plug#begin('~/.vim/plugged')
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'gelguy/wilder.nvim'
Plug 'preservim/nerdtree'
Plug 'ambv/black'

Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'xero/miasma.nvim'

"Plug 'ycm-core/YouCompleteMe'
Plug 'github/copilot.vim'
Plug 'tpope/vim-fugitive'
Plug 'brooth/far.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

let mapleader = '`'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:gruvbox_contrast_dark = "hard"
let g:ycm_confirm_extra_conf = 0

autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
autocmd vimenter *.txt execute ':set syntax=markdown'
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Custom mappings
map <leader>w :w<CR>
map <leader>q :wq<CR>
map <leader>c :close<CR>
map <leader>b :NERDTreeToggle<CR>
map <leader>c :Copilot<CR>
map <leader>g :Git<CR>
map <leader>p :call ToPdf()<CR>

" Run prettier on save
augroup PrettierAutoFormat
  autocmd!
  autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js Prettier
augroup END

" Custom commands
fun! ToPdf()
  silent !pandoc % -o %.pdf --pdf-engine=/Library/TeX/texbin/pdflatex -V geometry:margin=1in
  silent !open %.pdf
  redraw!

  " !~/.vim/compile.sh %  
endfun
command Pdf :call ToPdf()

set backspace=indent,eol,start
set background=dark
set smarttab
set number
set expandtab
set tabstop=4
set shiftwidth=2
set mouse=a
set cursorline
set clipboard=unnamedplus
" set wildmode=longest,list,full

" If on Windows, set termguicolors
if has('win32') || has('win64')
  set termguicolors
endif

autocmd vimenter * ++nested colorscheme gruvbox
" colorscheme peachpuff
augroup colorscheme_change | au! 
    " Make comments bold and green
    au ColorScheme * :highlight Comment ctermfg=green
    au ColorScheme * :highlight Comment cterm=bold
augroup end 
syntax enable
