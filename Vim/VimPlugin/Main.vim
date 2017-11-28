let column="false"
let indent="false"
let mouse="true"
let extension=expand('%:e')

let cmd="./"
let args=""

noremap <F2> :let args=""<left>
noremap <F3> :let cmd=""<left>
noremap J gq<left>
noremap L :noh<enter>
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
noremap <bar> :call Run()<enter>

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
    elseif g:extension == "sh"
        call Load("Bash")
    elseif g:extension == "m"
        call Load("Octave")
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

    exe "so ".auto

    if filereadable(print)
        exe "so ".print
    endif

    if filereadable(compile)
        exe "so ".compile
    else
        exe "so ".interpret
    endif

endfunction

function! Column()
    if g:column == "false"
        highlight OverLength ctermbg=red
        match OverLength /\%81v.\+/
                                    " \%81v from 81 character
                                    " . any character
                                    " \+ more than one
        let g:column="true"
    else
        highlight OverLength cterm=NONE ctermbg=black
        let g:column="false"
    endif

endfunction

function! Print()

    if g:extension == "C"
        :call PrintCpp()
    elseif g:extension == "c"
        :call PrintC()
    elseif g:extension == "m"
        :call PrintOctave()
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

call Start()
