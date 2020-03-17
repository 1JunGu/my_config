"       ___  __(_)___ ___
"       | | / / / __ `__ \
"       | |/ / / / / / / /
"       |___/_/_/ /_/ /_/
"
"   Contributor: GuJun <gj99@mail.ustc.edu.cn>
"   Version: 1.0
"   Created: 2020-03-16
"   Last Modified: 2020-03-16
"
source ~/.vim/bundles.vim
"------------------------------------------------
"" => Global Variables
"------------------------------------------------
let g:vim_expand_tab = 1
let g:vim_default_indent = 4
"------------------------------------------------
"" => General Options
"------------------------------------------------
"set nocompatible "Get out of vi compatible mode
"filetype plugin indent on "Enable filetype
set nu           "display line number
set ruler
set showcmd      "Show command
set showmatch    "Show matching bracket (briefly jump)
set history=1000 "Increase the lines of history
set encoding=utf-8 " Set utf-8 encoding

set complete-=k complete+=k " Add dictionary search (as per dictionary option)
set wildmode=list:full "Use powerful wildmenu
set wildmenu           " Show list instead of just completing
"------------------------------------------------
"" =>Colors and Fonts
"------------------------------------------------
syntax on " Enable syntax
set t_Co=256 " Use 256 colors

set background=dark " Set background
colorscheme desert

" Set GUI font
if has('gui_running')
    if has('gui_gtk')
            set guifont=DejaVu\ Sans\ Mono\ 18
    else
            set guifont=DejaVu\ Sans\ Mono:h18
	endif
endif

"------------------------------------------------
"" =>Cursor and highlight
"------------------------------------------------
set cursorline 
hi CursorLine cterm=underline ctermbg=none ctermfg=none
set nocursorcolumn
"hi CursorColumn cterm=none ctermbg=DarkMagenta ctermfg=White

"-------------------------------------------------
"" => Search
"-------------------------------------------------
set ignorecase " Case insensitive search
set smartcase  " Case sensitive when uc present
set hlsearch   " Highlight search terms
hi Search cterm=reverse ctermbg=none ctermfg=none
set incsearch  " Find as you type search
set gdefault   " Turn on g flag
                            
"-------------------------------------------------
"" => Indent
"-------------------------------------------------
set autoindent  " Preserve current indent on new lines
set smartindent " Indent one more or less time on new lines follwing braces
set cindent     " Set C style indent
let &expandtab=g:vim_expand_tab       " Convert all tabs typed to spaces
let &tabstop=g:vim_default_indent
let &softtabstop=g:vim_default_indent " Indentation levels every four columns
let &shiftwidth=g:vim_default_indent  " Indent/outdent by four columns
set smarttab
"------------------------------------------------
"" =>Ignore case sensitivity
"------------------------------------------------
:command! W w
:command! WQ wq
:command! Wq wq
:command! Q q
:command! Qa qa
:command! QA qa
"------------------------------------------------
"" => Status
"------------------------------------------------
set laststatus=2
set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
"set statusline=%#filepath#[%{expand('%:p')}]%#filetype#[%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%#filesize#%{FileSize()}%{IsBinary()}%=%#position#%c,%l/%L\ [%3p%%]
"hi filepath cterm=none ctermbg=238 ctermfg=40
"hi filetype cterm=none ctermbg=238 ctermfg=45
"hi filesize cterm=none ctermbg=238 ctermfg=225
"hi position cterm=none ctermbg=238 ctermfg=228
function IsBinary()
        if (&binary == 0)
            return ""
        else
            return "[Binary]"
        endif
endfunction
function FileSize()
        let bytes = getfsize(expand("%:p"))
        if bytes <= 0
            return "[Empty]"
        endif
        if bytes < 1024
            return "[" . bytes . "B]"
        elseif bytes < 1048576
            return "[" . (bytes / 1024) . "KB]"
        else
            return "[" . (bytes / 1048576) . "MB]"
        endif
endfunction

"------------------------------------------------
"" =>Plugin settings
"------------------------------------------------

"------------------------------------------------
"" =>Language
"------------------------------------------------
"for NCL
let ncl_fold=1
autocmd BufRead,BufNewFile *.ncl set filetype=ncl
autocmd Syntax newlang source $HOME/.vim/syntax/ncl.vim
autocmd BufRead,BufNewFile *.ncl set dictionary=$HOME/.vim/dictionary/ncl.dic

"for Fortran
let fortran_fold=1
let fortran_have_tabs=1

"------------------------------------------------
"" =>Insert file title
"------------------------------------------------
"New .ncl .F Insert headline automatically
autocmd BufNewFile *.sh,*.ncl,*.F,.f90 exec ":call SetTitle()" 
""Define function SetTitile 
func SetTitle()
		"if filetype is .ncl 
		if &filetype =='ncl'
				call setline(1,";------------------------------------------------------------")
				call append(line("."), "; File Name: ".expand("%"))
				call append(line(".")+1, "; Author: JunGu")
				call append(line(".")+2, "; Mail: gj99@mail.ustc.edu.cn")
				call append(line(".")+3, "; Created Time: ".strftime("%c"))
				call append(line(".")+4, ";---------------------------------------------------")
		endif
        if &filetype == 'sh' 
                call setline(1, "#############################################################") 
                call append(line("."), "# File Name: ".expand("%")) 
                call append(line(".")+1, "# Author: JunGu") 
                call append(line(".")+2, "# Mail: gj99@mail.ustc.edu.cn") 
                call append(line(".")+3, "# Created Time: ".strftime("%c")) 
                call append(line(".")+4, "####################################################") 
                call append(line(".")+5, "#!/bin/bash")
                call append(line(".")+6, "")
        endif
		"When a new file is created, it is automatically positioned to the end
		"of file
		autocmd BufNewFile * normal G
endfunc
