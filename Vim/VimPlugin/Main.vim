let column="false"
let indent="false"
let mouse="true"
let cmdPath="/home/alejandro/Github/Vim/VimPlugin/"
let auto="/Autocomplete"
let compile="/Compilation"
let print="/Print"
let extension=expand('%:e')

noremap cc :call Column()<enter>
noremap tt :tabnew<enter>
noremap H :map<enter>
noremap E :call Indent()<enter>
noremap S :call Print()<enter>
noremap M :call Mouse()<enter>
noremap r <C-R>
noremap W <C-W>
noremap V <C-V>
noremap <BS> <C-O>
noremap <space> :call Clean()<enter>
noremap <bar> :call Compile()<enter>

au BufNewFile Makefile :call Make()
au BufRead Makefile :call Make()

function! Make()
    set noexpandtab
    set nocindent
endfunction

function Start()
    if g:extension == "C" || g:extension == "h"
        call Load("Cpp")
    elseif g:extension == "c"
        call Load("C")
    elseif g:extension == "java"
        call Load("Java")
    elseif g:extension == "cs"
        call Load("Csharp")
    elseif g:extension == "tex"
        call Load("Latex")
    elseif g:extension == "hs"
        call Load("Haskell")
    elseif g:extension == "asm"
        call Load("Asm")
    endif
endfunction

function! Load(program)
    exe "so ".g:cmdPath.a:program.g:auto.g:auto.a:program.".vim"

    if filereadable(g:cmdPath.a:program.g:auto.g:print.a:program.".vim")
        exe "so ".g:cmdPath.a:program.g:auto.g:print.a:program.".vim"
    endif

    exe "so ".g:cmdPath.a:program.g:compile.g:compile.a:program.".vim"
endfunction

function! Column()
    exe "set colorcolumn=".join(range(81,200),',')
    if g:column == "false"
        exe "highlight ColorColumn ctermbg=7"
        let g:column="true"
    else
        exe "highlight ColorColumn ctermbg=0"
        let g:column="false"
    endif
endfunction

function! Indent()
    if g:indent == "true"
        set cindent
        echom "Indent enabled"
        let g:indent="false"
    else
        set nocindent
        echom "Indent disabled"
        let g:indent="true"
    endif
endfunction

function! Print()
    if g:extension == "C"
        :call PrintCpp()
    elseif g:extension == "c"
        :call PrintC()
    elseif g:extension == "java"
        :call PrintJava()
    elseif g:extension == "cs"
        :call PrintCsharp()
    endif
endfunction

function! Mouse()
    if g:mouse == "true"
        set mouse=r
        echom "Mouse disabled"
        let g:mouse="false"
    else
        set mouse=a
        echom "Mouse enabled"
        let g:mouse="true"
    endif
endfunction

function! Clean()
    exe '%s/\s\+$//'
endfunction

function! Compile()
    if g:extension == "C" || g:extension == "h"
        :call Gpp()
    elseif g:extension == "c"
        :call Gcc()
    elseif g:extension == "java"
        :call Javac()
    elseif g:extension == "cs"
        :call Gmcs()
    elseif g:extension == "hs"
        :call Ghc()
    elseif g:extension == "tex"
        :call PdfLatex()
    elseif g:extension == "asm"
        :call Nasm()
    endif
endfunction

call Start()
