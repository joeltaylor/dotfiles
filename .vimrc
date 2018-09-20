call plug#begin('~/.vim/plugged')

Plug 'vim-ruby/vim-ruby'
Plug 'sjl/gundo.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'bronson/vim-trailing-whitespace'
Plug 'kana/vim-textobj-user' "rubyblock dependency
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'jgdavey/vim-blockle'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'sunaku/vim-ruby-minitest'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'othree/yajs.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Trevoke/ultisnips-rspec'
Plug 'w0rp/ale'
Plug 'qpkorr/vim-bufkill'
Plug 'luochen1990/rainbow'
Plug 'chriskempson/base16-vim'

" all of your plugins must be added before the following line
" Initialize plugin system
call plug#end()
let g:jsx_ext_required = 0

" Color scheme
set termguicolors
let base16colorspace=256
colorscheme base16-twilight
highlight LineNr guibg=NONE


let g:UltiSnipsSnippetDirectories=["mysnippets"]

set clipboard=unnamed

" Treat underscores as words
set iskeyword-=_

" Trying out breakindenet
" set breakindent

" Undofile
"
" Undo changes even after a file as been closed then reopened
if !isdirectory($HOME."/.vim")
  call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

" Better folding shortcut
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Close buffer but not split
" Disabled while tring out bufkill
" nmap ,d :b#<bar>bd#<CR>

" Fast spec access
nmap <leader>a :A<CR>

map <leader>R :call VimuxRunCommand("clear; ruby " . bufname("%"))<CR>

" Write contents of the file automatically
set autowrite

autocmd filetype ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd filetype ruby,eruby let g:rubycomplete_rails = 1

" Automatic wrap for quickfix
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

" I hate ex mode
nnoremap Q <nop>

" Sanity
command! WQ wq
command! Wq wq
command! W w
command! Q q

" Rails sanity
command! Rdb AsyncRun bin/rails db:environment:set RAILS_ENV=test


" Colorized brackets
let g:rainbow_active = 0
autocmd filetype html call rainbow#toggle()


" Skip quickfix when cycling buffers
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END

" Only this buffer
command! O only

" leader is comma
let mapleader=","

let g:tmux_navigator_no_mappings = 1
let g:rspec_runner = "os_x_iterm2"

" Don't wrap when I rap code
set textwidth=0
set wrapmargin=0

au FileType notes setlocal wrap
au FileType notes setlocal linebreak
au FileType notes setlocal nolist
au FileType notes setlocal textwidth=80

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-C> :TmuxNavigatePrevious<cr>

"remove file-beagle mapping
map <silent> <leader>f  <plug>filebeagleopencurrentworkingdir
let g:filebeagle_show_hidden = 1


set wildmenu            " visual autocomplete for command menu

nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>n :TestNearest<CR>
let test#strategy = "asyncrun"
let test#ruby#rspec#executable = 'rspec --fail-fast'

noremap \q :call asyncrun#quickfix_toggle(8)<cr>

" let test#ruby#minitest#file_pattern = '.rb' " the default is '_test\.rb'
" let g:test#ruby#minitest#executable = 'ruby %'

map \[ :let g:asyncrun_mode=0<CR>
map \] :let g:asyncrun_mode=1<CR>

" yank whole file
map YY :%y<cr>

"For buffers, it hides the rest if the current is modified
set hidden

" General
set number
set numberwidth=1
set ruler
set cursorline
set cursorcolumn
set tags=./tags;
set nocompatible
set backspace=indent,eol,start
" set smartindent
set autoindent "always set autoindenting on
set history=50 "keep 50 lines in the command history
set showcmd "display incomplete commands
set incsearch "do incremental searching
set nowrap "becuase why the fuck would I ever want to wrap code?
let ruby_space_errors = 1

map <leader>d :BD<CR>
map <leader>q :bd<CR>

" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"jk is escape
imap jk <esc>

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set binary
set expandtab
set shiftround
set scrolloff=2
set laststatus=2


" highlight list ctermfg=red
set list
" set lcs+=tab:▸▸\
" set lcs+=eol:
set listchars=tab:▸·


" Generate Ctags
map <leader>rt :AsyncRun ctags -R --exclude="*.log" --exclude="node_modules" --exclude="vendor" .<CR><CR>
set tags+=.git/tags

" Make git-gutter look better.
" This must go after the color scheme.
highlight clear SignColumn
highlight GitGutterAdd ctermbg=none ctermfg=green
highlight GitGutterChange ctermbg=none ctermfg=yellow
highlight GitGutterDelete ctermbg=none ctermfg=red
highlight GitGutterChangeDelete ctermbg=none ctermfg=yellow
highlight SignColumn ctermbg=none

"ALE highlights
highlight clear ALEWarning

let g:ale_linters = {
      \   'eruby': ['html', 'css'],
      \}

augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END


" GIVE ME PRETTY JSON
com! PrettyJson %!python -m json.tool

if has("autocmd")
  " Jump to last-known-position when editing files
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd FileType gitcommit 0

  " Credit: tpope
  " Deletes swapfiles for unmodified buffers
  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave * if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
endif

set ttimeoutlen=100

" Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
set encoding=utf-8
" let g:tmuxline_powerline_separators = 0
let g:airline_theme = 'base16_twilight'
let g:airline#extensions#tmuxline#enabled = 1

set statusline+=%{fugitive#statusline()}
set statusline+=%#warningmsg#
set statusline+=%*

let g:airline_section_warning = airline#section#create_right(['%{g:asyncrun_status}']) "asyncrun
" highlight ColorColumn ctermbg=238 guibg=#5d5d5d
execute "set colorcolumn=" . join(range(81,335), ',')

" Scroll with the mouse wheel
set mouse=nicr

" Kill whitespace
noremap ;f :FixWhitespace<CR>

"Set spell check when editing markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" fzf
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)


" Fuzzy-find with fzf
map <C-p> :Files<cr>
nmap <C-p> :Files<cr>
map <C-f> :Ag<CR>
nmap ; :Buffers<CR>

" [Files] Extra options for fzf
"   e.g. File preview using Highlight
"        (http://www.andre-simon.de/doku/highlight/en/highlight.html)
let g:fzf_files_options =
      \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" [Tags] Command to generate tags file
" let g:fzf_tags_command = 'ctags -R'


function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
        \ 'ctrl-v': 'vertical split',
        \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
      \ 'source':  printf('ag --nogroup --column --color "%s"',
      \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
      \ 'sink*':    function('<sid>ag_handler'),
      \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
      \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
      \            '--color hl:68,hl+:110',
      \ 'down':    '30%'
      \ })
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
      \                         : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '|'),
      \                 <bang>0)

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('<sid>bufopen'),
      \   'options': '+m',
      \   'down':    len(<sid>buflist()) + 2
      \ })<CR>



" vim-notes
let g:notes_directories = ['~/Dropbox/Notes']

" Ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_text_change = 0
let g:ale_line_on_enter = 0
let g:ale_enabled = 1

"GitGutter
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
