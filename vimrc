set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

set textwidth=0		" Don't wrap lines by default 
set backupcopy=yes	" Keep a backup file
set viminfo='20,\"50	" read/write file .viminfo, store<=50 lines of registers
set history=50		" keep 50 lines of command line history
" set number          " show line numbers
set hidden

colorscheme ngc224colorscheme
set background=dark

set showcmd		" Show (partial) command in status line.
set showmatch	" Show matching brackets.
set ignorecase	" Do case insensitive matching
set smartcase " Do both case sensitive and case insensitive searches
set incsearch	" Incremental search
set hlsearch " Do highlight search

set shiftwidth=4
set shiftround
set autoindent		
set cindent
set expandtab
set smarttab
set tabstop=4
set softtabstop=4

set encoding=utf-8
set fileencodings=utf-8


noremap <leader>s :nohl<CR>
noremap <leader>o o<Esc>
noremap <leader>O O<Esc>
noremap <leader>e :Explore<CR>

noremap ,d :b#<bar>bd#<CR>
noremap <leader>] zj
noremap <leader>[ zk
noremap C zC

let g:netrw_liststyle = 3
let g:netrw_list_hide = '.*\.swp$,.*\.pyc$'

" by Proskurnev: Highlight .tyaml syntax
au BufRead,BufNewFile *.tyaml set filetype=yaml

" by Proskurnev: Manual file encoding selection. To select file enconding press <F8>
function! ChangeFileencoding()
    let encodings = ['cp1251', 'koi8-u', 'cp866', 'utf-8']
    let prompt_encs = []
    let index = 0
    while index < len(encodings)
            call add(prompt_encs, index.'. '.encodings[index])
            let index = index + 1
    endwhile
    let choice = inputlist(prompt_encs)
    if choice >= 0 && choice < len(encodings)
            execute 'e ++enc='.encodings[choice].' %:p'
    endif
endf
nmap <F8> :call ChangeFileencoding()<CR>


" Prepare Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Disable arrows antipattern
Plugin 'wikitopian/hardmode' 

" Enable fuzzy search
Plugin 'kien/ctrlp.vim'

" Provide extra buffer capabilities
Plugin 'jeetsukumaran/vim-buffergator'

" Do syntax checking
Plugin 'scrooloose/syntastic'

" Allow subexpression type inference
Plugin 'eagletmt/ghcmod-vim'

" ghcmod dependency
Plugin 'Shougo/vimproc.vim'

" Do completion
Plugin 'Valloric/YouCompleteMe'

" Allow semantic completion for haskell
Plugin 'eagletmt/neco-ghc'

" Provide python IDE capabilities
Plugin 'davidhalter/jedi-vim'

" Show csv files nicely
Plugin 'chrisbra/csv.vim'

" Status-bar
Plugin 'bling/vim-airline'

" Git integration
Plugin 'tpope/vim-fugitive'

" Minimalistic colorscheme creation
Plugin 'Heldraug/Vim-Colorscheme-Template'

" Allow easy commenting
Plugin 'tomtom/tcomment_vim'

" Allow easy rst editing
Bundle 'Rykka/riv.vim'

" Support nice python foldings
" Plugin 'tmhedberg/SimpylFold'

call vundle#end()


syntax on		
filetype plugin indent on

" HardMode settings
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" CtrlP settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|pyc)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in
" version control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_clear_cache_on_exit = 0

" Enable fuzzy search on buffer contents
let g:ctrlp_extensions = ['line']

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
" nmap <leader>pb :CtrlPBuffer<cr>
" nmap <leader>pm :CtrlPMixed<cr>
" nmap <leader>ps :CtrlPMRU<cr>
" nmap <leader>pl :CtrlPLine<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Buffergator settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'

" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1

" Looper buffers
let g:buffergator_mru_cycle_loop = 1

" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>

" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>

" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Syntastic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" handy way to close location list
nmap <leader>lq :lclose<CR><CR>
nmap <leader>ln :lnext<CR><CR>
nmap <leader>lp :lprev<CR><CR>

" call syntastic manually
nmap <leader>c :call SyntasticCheck()<CR>

" show checker & language
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_signs = 0

let g:syntastic_python_checkers = ['flake8',]
" let g:syntastic_python_pylint_post_args='--disable=C0103,C0111'
let g:syntastic_python_flake8_args = "--max-line-length=80"

let g:syntastic_haskell_checkers = ['ghc_mod',]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" YouCompleteMe settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = "~/repos/dotfiles/vimrc/ycm.py"

" don't complete on ->
let g:ycm_semantic_triggers = {'haskell' : ['.']}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" neco-ghc settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable completion
au BufRead,BufNewFile *.hs  setlocal omnifunc=necoghc#omnifunc

" show haskell function signatures
let g:necoghc_enable_detailed_browse = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Jedi-vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" don't show preview window
autocmd FileType python setlocal completeopt-=preview

" use buffers not tabs
let g:jedi#use_tabs_not_buffers = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show statusline all the time
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" riv settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:riv_fold_level = -1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" SimpylFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
