let column="false"
let indent="false"
let mouse="true"
let makeThis="false"
let extension=expand('%:e')
let name=expand('%:r')

let cmd="./"
let args=""
let mkargs=""

noremap <F2> :let args=""<left>
noremap <F3> :let cmd=""<left>
noremap <F4> :let mkargs=""<left>
noremap K :call MakeThis()<enter>
noremap X :call MakeExe()<enter>
noremap J gq<left>
noremap L :noh<enter>
noremap tt :tabnew<enter>
noremap H :map<enter>
noremap E :call Indent()<enter>
noremap S :call Print()<enter>
noremap M :call Mouse()<enter>
noremap r <C-R>
noremap W <C-W>
noremap U :call Sudo()<enter>
noremap V <C-V>
noremap <BS> <C-O>
noremap <space> :call Clean()<enter>
noremap <bar> :call Run()<enter>

au BufNewFile Makefile :call Make()
au BufRead Makefile :call Make()

function! Make()
    set noexpandtab
    set nocindent
endfunction

function Start()
    if g:extension == "C" || g:extension == "cpp" || g:extension == "h"
        call Load("Cpp")
    elseif g:extension == "c"
        call Load("C")
    elseif g:extension == "sh"
        call Load("Bash")
    elseif g:extension == "m"
        call Load("Octave")
    elseif g:extension == "py"
        call Load("Python")
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

    let cmdPath=expand('~/Github/Vim/VimPlugin/')
    let auto=cmdPath.a:program."/Autocomplete.vim"
    let print=cmdPath.a:program."/Print.vim"
    let compile=cmdPath.a:program."/Compilation.vim"
    let interpret=cmdPath.a:program."/Interpret.vim"

    if filereadable(auto)
        exe "so ".auto
    endif

    if filereadable(print)
        exe "so ".print
    endif

    if filereadable(compile)
        exe "so ".compile
    else
        exe "so ".interpret
    endif

endfunction

function! Print()

    if g:extension == "C" || g:extension == "cpp"
        :call PrintCpp()
    elseif g:extension == "c"
        :call PrintC()
    elseif g:extension == "m"
        :call PrintOctave()
    elseif g:extension == "py"
        :call PrintPython()
    elseif g:extension == "java"
        :call PrintJava()
    elseif g:extension == "cs"
        :call PrintCsharp()
    elseif g:extension == "asm"
        :call PrintAsm()
    endif

endfunction

function! Run()
    if g:extension == "C" || g:extension == "cpp"
        :call Gpp()
    elseif g:extension == "c"
        :call Gcc()
    elseif g:extension == "sh"
        :call BashC()
    elseif g:extension == "m"
        :call OctaveC()
    elseif g:extension == "py"
        :call PythonC()
    elseif g:extension == "java"
        :call Javac()
    elseif g:extension == "cs"
        :call Gmcs()
    elseif g:extension == "hs"
        :call Ghc()
    elseif g:extension == "tex"
        :call PdfLatex()
    elseif g:extension == "asm" || g:extension == "inc"
        :call Nasm()
    endif

endfunction

function! MakeExe()
    exe "w !chmod u+x ".expand('%')
    echom "This file is now executable."
endfunction

function! MakeThis()

    if g:makeThis == "true"
        let g:mkargs=""
        echom "Make only this disabled"
        let g:makeThis="false"
    else
        let g:mkargs="%:r"
        echom "Make only this enabled"
        let g:makeThis="true"
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
    exe '%s/\s\+$//e'
    exe '%s/\t/    /ge'
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

function! Sudo()
    exe "w !sudo tee % > /dev/null"
endfunction

call Start()
