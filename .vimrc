" ==========================================
"              T_BAO GVIM CONFIG
"             C++ COMPETITIVE PROGRAMMING
" ==========================================
source $VIMRUNTIME/vimrc_example.vim
" ------------------------------------------
" GENERAL
" ------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
set nocompatible
set hidden
set backspace=indent,eol,start
set hls
set is
set clipboard=unnamed
set guifont=DepartureMono_Nerd_Font:h16
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set number
set relativenumber
set cursorline
set showmatch
set scrolloff=5
set sidescrolloff=5
set wildmenu
set wildmode=longest:full,full
set splitright
set splitbelow
set updatetime=300
set signcolumn=no
" ------------------------------------------
" WINDOW
" ------------------------------------------
au GUIEnter * simalt ~x
" ------------------------------------------
" AUTO PAIRS
" ------------------------------------------
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}
inoremap [ []<Left>
inoremap [<CR> [<CR>]<Esc>O
inoremap [[ [
inoremap [] []
inoremap ( ()<Left>
inoremap (<CR> (<CR>)<Esc>O
inoremap (( (
inoremap () ()
inoremap ' ''<Left>
inoremap '<CR> '<CR>'<Esc>O
inoremap '' '
inoremap '' ''
inoremap " ""<Left>
inoremap "<CR> "<CR>"<Esc>O
inoremap "" "
inoremap "" ""
" ------------------------------------------
" C++ COMPILER SETTINGS
" ------------------------------------------
let g:cpp_compiler = 'g++'
let g:cpp_flags = '-std=c++17 -O2 -Wall -Wextra'
" ------------------------------------------
" COMPILE C++
" ------------------------------------------
function! CompileCpp()
    write
    let l:src = expand('%:p')
    let l:out = expand('%:p:r') . '.exe'
    echo 'Compiling...'
    execute '!' . g:cpp_compiler . ' ' . g:cpp_flags
                \ . ' "' . l:src . '" -o "' . l:out . '"'
endfunction
" ------------------------------------------
" RUN C++
" ------------------------------------------
function! RunCpp()
    let l:out = expand('%:p:r') . '.exe'
    if !filereadable(l:out)
        echohl WarningMsg
        echo 'Executable not found! Press F9 first.'
        echohl None
        return
    endif
    execute '! "' . l:out . '"'
endfunction
" ------------------------------------------
" DELETE EXECUTABLE
" ------------------------------------------
function! DeleteExe()
    let l:out = expand('%:p:r') . '.exe'
    if filereadable(l:out)
        call delete(l:out)
        echo 'Executable deleted!'
    else
        echo 'No executable found!'
    endif
endfunction
" ------------------------------------------
" C++ KEY MAPPINGS
" ------------------------------------------
augroup CppCompile
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <F9> :call CompileCpp()<CR>
    autocmd FileType cpp nnoremap <buffer> <F10> :call RunCpp()<CR>
    autocmd FileType cpp nnoremap <buffer> <F11> :call DeleteExe()<CR>
augroup END
" ------------------------------------------
" COMMENT / UNCOMMENT
" ------------------------------------------
autocmd FileType cpp nnoremap <buffer> <C-C> :s/^\(\s*\)/\1\/\/<CR>
autocmd FileType cpp vnoremap <buffer> <C-C> :s/^/\/\/<CR>
" ------------------------------------------
" NUMBER TOGGLE
" ------------------------------------------
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
" ------------------------------------------
" DIFF
" ------------------------------------------
set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase'
        let opt = opt . '-i '
    endif
    if &diffopt =~ 'iwhite'
        let opt = opt . '-b '
    endif
    let arg1 = v:fname_in
    if arg1 =~ ' '
        let arg1 = '"' . arg1 . '"'
    endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' '
        let arg2 = '"' . arg2 . '"'
    endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' '
        let arg3 = '"' . arg3 . '"'
    endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote = l:shxq_sav
    endif
endfunction
" ==========================================
"                  END
" ==========================================
