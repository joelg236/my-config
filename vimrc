" Plugins
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    " Vim stuff
    Plugin 'tpope/vim-sensible'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-endwise'
    Plugin 'wellle/targets.vim'
    Plugin 'vim-scripts/AutoClose'
    Plugin 'terryma/vim-expand-region'
    Plugin 'unblevable/quick-scope'
    Plugin 'michaeljsmith/vim-indent-object'
    Plugin 'tpope/vim-repeat'
    Plugin 'bronson/vim-visual-star-search'
    Plugin 'kana/vim-operator-user'

    " Git
    Plugin 'airblade/vim-gitgutter'
    Plugin 'tpope/vim-fugitive'

    " Files & buffers
    Plugin 'tpope/vim-vinegar'
    Plugin 'jlanzarotta/bufexplorer'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'mhinz/vim-startify'

    " Theming
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'the31k/vim-colors-tayra'

    " Language specific
    Plugin 'digitaltoad/vim-pug'
    Bundle 'yalesov/vim-emblem'
    Plugin 'rust-lang/rust.vim'
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'tpope/vim-rails'
    Plugin 'rhysd/vim-clang-format'
    Plugin 'keith/swift.vim'
    Plugin 'editorconfig/editorconfig-vim'

    call vundle#end()
    filetype plugin indent on

" Looks
    syntax enable
    colorscheme tayra
    let g:airline_theme = 'bubblegum'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#fnamemod = ':p:s?/home/joel/dev/??:~'
    let g:airline_left_sep=''
    let g:airline_right_sep=''
    set number
    set list " Show invisible characters
    set listchars=tab:>-,trail:~,extends:>,precedes:<

" Shortcuts
    " I really like space as a leader
    let mapleader = "\<Space>"

    " Reloads the saved $MYVIMRC
    map <leader>s :source $MYVIMRC<CR>

    " e finds open buffers
    map <leader>e :BufExplorer<CR>

    " Paste something
    map <leader>p :setlocal paste !<CR>

    " Save file
    map <Leader>w :w<CR>
    map <Leader>q :q<CR>
    map <Leader>Q :qa<CR>

    " v expands visual selection
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)

    " go gives you newline without insert
    map go o<esc>k

    " H & L goes to start & end of line
    map H ^
    map L $

    " Wrap-independant movement
    nmap <silent> j gj
    nmap <silent> k gk

    " K splits line, inverse of J
    noremap K i<CR><esc>k:s/\s\+$//e<CR>j:noh<CR>

    " * finds current, don't skip ahead please
    nmap * *N<esc>
    vmap * y/<C-R>"<CR>N

    " clipboard buffer access
    map <leader>c "+

    autocmd FileType c,cpp,objc nnoremap <buffer><C-f> :<C-u>ClangFormat<CR>zz
    autocmd FileType c,cpp,objc vnoremap <buffer><C-f> :ClangFormat<CR>zz

    " Highlight all instances of word under cursor, when idle.
    " Useful when studying strange source code.
    " Type C-g to toggle highlighting on/off.
    nnoremap <C-g> :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
    function! AutoHighlightToggle()
      let @/ = ''
      if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
      else
        augroup auto_highlight
          au!
          au CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
      endif
    endfunction

    let @r = 'n.'
    nmap ! mm100@r'm

" Navigation
    " Switch buffers
    map <leader>J :bprev<CR>
    map <leader>K :bnext<CR>
    " Switch tabs easily
    map <tab>j :tabprevious<CR>
    map <tab>k :tabnext<CR>
    " Exit buffer nicely keeping window open
    command! BW :bn|:bd#
    map <leader>x :BW<CR>

    set mouse=n
    nnoremap <LeftMouse> <nop>

    " Open split with y or u
    set splitbelow
    set splitright
    map <leader>y :split<CR>
    map <leader>u :vsplit<CR>

    " Switch between split windows
    map <leader>h <C-w>h
    map <leader>j <C-w>j
    map <leader>k <C-w>k
    map <leader>l <C-w>l
    map <c-k> :resize -5<CR>
    map <c-j> :resize +5<CR>
    map <c-h> :vertical resize +5<CR>
    map <c-l> :vertical resize -5<CR>
    " Stop doing that!
    inoremap <Up> <esc>
    inoremap <Down> <esc>
    inoremap <Left> <esc>
    inoremap <Right> <esc>

    " star search
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

    " Folding based on indents
    set foldmethod=indent
    set foldlevelstart=99

    " Enter switches fold
    map <silent> <Return> @=(foldlevel('.')?'za':"\<Return\>")<CR>
    set foldtext=""

    " Center cursor
    set so=5
    set cursorline

    map _ :Startify<CR>
    map - :e .<CR>
    let g:netrw_liststyle=3

    " Toggle Vexplore with Ctrl-E
    function! ToggleVExplorer()
      if exists("t:expl_buf_num")
          let expl_win_num = bufwinnr(t:expl_buf_num)
          if expl_win_num != -1
              let cur_win_nr = winnr()
              exec expl_win_num . 'wincmd w'
              close
              exec cur_win_nr . 'wincmd w'
              unlet t:expl_buf_num
          else
              unlet t:expl_buf_num
          endif
      else
          exec '1wincmd w'
          Vexplore
          let t:expl_buf_num = bufnr("%")
      endif
    endfunction
    map <silent> <C-e> :call ToggleVExplorer()<CR>

" Searching
    " Case only matters when I ask
    set smartcase
    set ignorecase

    " Highlight search results incrementally
    set hlsearch
    set incsearch

    " Turn off search with g-h
    map gh :silent noh<CR>

    set wildmode=full

    let g:ctrlp_custom_ignore = 'build\|.git'

" Backup and externals
    set hidden
    set swapfile
    set directory=$TMPDIR,~/.tmp,~/.vim/tmp,/tmp,/var/tmp
    set backup
    set backupdir=$TMPDIR,~/.tmp,~/.vim/tmp,/tmp,/var/tmp
    set viminfo+=n~/.vim/viminfo

    if has('persistent_undo')
        set undodir=$TMPDIR,~/.tmp,~/.vim/tmp,/tmp,/var/tmp
        set undofile
        set undoreload=10000
    end
    set undolevels=10000

" Indents and  styling
    " Use spaces instead of tabs
    set expandtab

    " Be smart when using tabs/indents
    set smarttab
    set smartindent

    " 1 tab == 4 spaces, the only correct way
    set shiftwidth=4
    set tabstop=4

    " Wrap lines
    set formatoptions+=1
    set breakindent
    set nowrap
    highlight ColorColumn ctermbg=236
    set colorcolumn=80

" Spell Check
    " Spell check toggle ,ss
    map <leader>ss :setlocal spell ! spelllang=en_ca<CR>

    " Spell check shortcuts
    map <leader>sn ]s<CR>
    map <leader>sp [s<CR>
    map <leader>sa zg<CR>
    map <leader>s? z=<CR>

" Abbreviations
    iab #i #include
    iab #d #define
    iab teh the
    iab erturn return
    iab retrun return
    iab seperate separate
    iab dont don't
    iab waht what
    iab tehn then

" Misc
    " God damn Ex mode
    map Q <nop>
    " I've never needed this
    map q: <nop>
    " Hack for http://vim.wikia.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell
    inoremap [A <nop>
    inoremap [B <nop>
    inoremap [C <nop>
    inoremap [D <nop>
    " json
    autocmd BufNewFile,BufRead *.json setf javascript
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    nnoremap <C-LeftMouse> <nop>
    set noautochdir
    let g:gitgutter_map_keys = 0
    let g:clang_format#command = 'clang-format-3.5'
    let g:startify_change_to_vcs_root = 1
    let g:startify_list_order = [['   Current directory:'], 'dir']
    let g:startify_custom_header = [
            \ '                               ',
            \ '            __                 ',
            \ '    __  __ /\_\    ___ ___     ',
            \ '   /\ \/\ \\/\ \ /'' __` __`\  ',
            \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \  ',
            \ '    \ \___/  \ \_\ \_\ \_\ \_\ ',
            \ '     \/__/    \/_/\/_/\/_/\/_/ ',
            \ '                               ',
            \ ]
