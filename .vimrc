set nocompatible "vi非互換モード
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"#######################
" Display
"#######################
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set scrolloff=5 "スクロールの余白
set nowrap
set cursorline

"#######################
" Move
"#######################
set whichwrap=b,s,h,l,<,>,[,]

"#######################
" Syntax
"#######################

syntax on "カラー表示
set smartindent "オートインデント
" tab関連
":set expandtab "タブの代わりに空白文字挿入
set list
set listchars=trail:-,tab:>\ ,extends:<

set tabstop=4
set shiftwidth=4
set softtabstop=0

"#######################
" Search
"#######################
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch
set hlsearch

set wildmode=longest,list

"#######################
" Others
"#######################
"カラースキーマ
set t_Co=256
colorscheme desert

"#######################
" Key Mapping
"#######################
"ノーマルモードで空白を挿入
"nnoremap <C-m> o<ESC>

"検索語を真ん中に表示
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

nnoremap <C-w><Space> :bn<CR>
nnoremap <C-w><BS> :bp<CR>
nnoremap <C-w>n :bn<CR>
nnoremap <C-w>p :bp<CR>
nnoremap <C-w>d :bd<CR>

" insert mode での移動
imap <C-e> <END>
imap <C-a> <HOME>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>


"#######################
" plugin
"#######################

"pathogen
filetype off
call pathogen#runtime_append_all_bundles()

"ftplugin
filetype plugin on

"coffeescript
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

" neocomplcache
"let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
"let g:neocomplcache_force_overwrite_completefunc = 1 " なんかエラー出るのでとりあえず

" スニペットファイルの配置場所
let g:NeoComplCache_SnippetsDir = '~/.vim/snippets'
imap <silent> <C-S> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-S> <Plug>(neocomplcache_snippets_expand)

"BufferExplorer
nnoremap <C-l> :BufExplorer<CR>

"YankRing
nnoremap ,y :YRShow<CR>

"syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_disabled_filetypes = []
