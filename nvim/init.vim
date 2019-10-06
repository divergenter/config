filetype off

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight', { 'for' : ['c', 'cpp'] }
Plug 'vim-scripts/TagHighlight'
Plug 'Raimondi/delimitMate'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'luochen1990/rainbow'
Plug 'roxma/nvim-completion-manager'  " auto complete code
Plug 'universal-ctags/ctags'
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'mhinz/vim-startify'
"Plug 'yonchu/accelerated-smooth-scroll'
"Plug 'easymotion/vim-easymotion'
Plug 'ntpeters/vim-better-whitespace' " highlight tail whiteSpace
call plug#end()


filetype plugin indent on
let mapleader = "\<Space>"
nnoremap <Leader>w :wq<CR>
nnoremap <Leader>q :qall!<CR>
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>s :sp<CR>

nnoremap <Leader>c :noh<CR>
nnoremap <Leader>r :%s/
nnoremap <C-p> :reg<CR>
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>n <C-w>w
nnoremap <Leader>, ^
nnoremap <Leader>. $

let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
let g:airline= {'colorscheme':'onedark'}
colorscheme onedark
"colorscheme plastic
" NERDTreens.vim config
map <F2> : NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

let g:ackprg = 'ag --nogroup --nocolor --column'

" fzf settings
"set rtp+=~/.fzf
"<Leader>f在当前目录搜索文件
"
nnoremap <silent> <Leader>f :Files<CR>
"<Leader>b切换Buffer中的文件
nnoremap <silent> <Leader>b :Buffers<CR>
"<Leader>p在当前所有加载的Buffer中搜索包含目标词的所有行，:BLines只在当前Buffer中搜索
nnoremap <silent> <Leader>p :Lines<CR>
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 ' rg --column --line-number --no-heading --color=always --smart-case --hidden --layout=reverse'.shellescape(<q-args>), 1,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>a :Ag<CR>

" Tagbar
let g:tagbar_width=50
let g:tagbar_autofocus=1
let g:tagbar_right=1
nmap <F4> :TagbarToggle<CR>

" setting rainbow_active
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\	'ctermfgs': ['lightblue', 'lightyellow', 13, 10, 'red', 28, 105],
\	'operators': '_,_',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody',
\		},
\	}
\}

"acpp-enhanced-highlight
""高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 100
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
let g:cpp_experimental_template_highlight = 1

" inoremap settins
inoremap <expr> <Tab> pumvisible()?"\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible()?"\<C-n>" : "\<S-Tab>"
set shortmess+=c

let g:clipboard = {
      \   'name': 'myClipboard',
      \   'copy': {
      \      '+': {lines, regtype -> extend(g:, {'foo': [lines, regtype]}) },
      \      '*': {lines, regtype -> extend(g:, {'foo': [lines, regtype]}) },
      \    },
      \   'paste': {
      \      '+': {-> get(g:, 'foo', [])},
      \      '*': {-> get(g:, 'foo', [])},
      \   },
      \ }

let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/path/to/share/gtags/gtags.conf'

set cscopetag
set cscopeprg='gtags-cscope'


"gtags.vim
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" ½«×Ô¶¯Éú³ÉµÄ ctags/gtags ÎÄ¼þÈ«²¿·ÅÈë ~/.cache/tags Ä¿Â¼ÖÐ£¬±ÜÃâÎÛÈ¾¹¤³ÌÄ¿Â¼
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif
let g:gutentags_auto_add_gtags_cscope = 0

" sync C++ check settings
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" indent guide
let g:indent_guides_enable_on_vim_startup=1

" easy move
" Move to linemap <Leader>L <Plug>(easymotion-bd-jk)
" nmap <Leader>L <Plug>(easymotion-overwin-line)
" map f <Plug>(easymotion-prefix)
" map ff <Plug>(easymotion-s)
" map fs <Plug>(easymotion-f)
" map fl <Plug>(easymotion-lineforward)
" map fj <Plug>(easymotion-j)
" map fk <Plug>(easymotion-k)
" map fh <Plug>(easymotion-linebackward)
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

syntax on
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autoindent
set cindent
set nu
hi nu   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

set clipboard+=unnamedplus
set tags=./.tags,.tags


set cursorline
hi CursorLine   cterm=NONE ctermbg=53 ctermfg=NONE guibg=NONE guifg=NONE
