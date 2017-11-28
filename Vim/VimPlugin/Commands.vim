let column="false"
let indent="false"
let mouse="true"

noremap H :map<enter>
noremap cc :call Column()<enter>
noremap E :call Indent()<enter>
noremap tt :tabnew<enter>
noremap S :call Print()<enter>
noremap M :call Mouse()<enter>
noremap <space> :call Clean()<enter>
noremap <F2> :call Javac()<enter>
noremap <F3> :call Gcc()<enter>
noremap <F4> :call Ghc()<enter>
noremap <F5> :call LatexBib()<enter>
noremap <F6> :call Latex()<enter>
noremap <F7> :call LatexDiap()<enter>
noremap r <C-R>
noremap W <C-W>
noremap V <C-V>
noremap <BS> <C-O>

au BufNewFile *.C :call Cpp()
au BufNewFile *.h :call Hpp()
au BufNewFile *.java :call Java()
au BufNewFile *.hs :call Haskell()
au BufRead Makefile set noexpandtab

function! Cpp()
    exe "normal i#include <iostream>\n\n
        \using namespace std;\n\n
        \int main(int argc, char *argv[]){\n\n
        \}"
    exe "normal k"
    exe "normal i\t"
endfunction

function! Gcc()
    let name=expand('%:r')
    if filereadable("Makefile")
        make
        make exe
    else
        exe "normal tt"
        call MakeCppHead(name)
        call MakeCppClean()
        call MakeCppExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call Gcc()
    endif
endfunction

function! MakeCppHead(name)
    set noexpandtab
    set nocindent
    exe "normal i".a:name.": ".a:name.".o\n
        \\tg++ ".a:name.".o -o ".a:name."\n\n"
        \.a:name.".o: ".a:name.".C\n
        \\tg++ -c ".a:name.".C"
endfunction

function! MakeCppClean()
    set noexpandtab
    set nocindent
    exe "normal o\nclean:\n\trm -f *.o"
endfunction

function! MakeCppExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction

function! Hpp()
    let name=toupper(expand('%:r'))
    exe "normal i#ifndef"name"\n
        \#define"name"\n
        \\n
        \\n
        \\n
        \#endif"
    call Clean()
    exe "normal 2j"
endfunction

function! Java()
    let name=expand('%:r')
    exe "normal ipublic class ".name."{\n\n
        \public ".name."(){\n\n}\n\n
        \public static void main(String[] args){\n
        \".name tolower(name)." = new ".name."();\n
        \}\n
        \}"
endfunction

function! Javac(...)
    let name=expand('%:r')
    if filereadable("Makefile")
        make
        make exe
    else
        exe "normal tt"
        call MakeJavaHead(name)
        call MakeJavaClean()
        call MakeJavaExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call Javac()
    endif
endfunction

function! MakeJavaHead(name)
    set noexpandtab
    set nocindent
    exe "normal i".a:name.".class: ".a:name.".java\n
        \\tjavac ".a:name.".java\n"
endfunction

function! MakeJavaClean()
    exe "normal o\nclean:\n\trm -f *.class"
endfunction

function! MakeJavaExe(name)
    exe "normal o\nexe:\n\tjava ".a:name
endfunction

function! Haskell()
    exe "normal imain = print()"
endfunction

function! Ghc(...)
    echom system("ghc ".expand('%'))
    exe "!if [ $? -eq 0 ]; then
        \   ./".expand('%:r')." ".join(a:000)";
        \   rm -f *hi *.o ".expand('%:r').";
        \ fi"
endfunction

function! Clean()
    exe '%s/\s\+$//'
endfunction

function! Print()
    let extension=expand('%:e')
    if extension == "C"
        exe "normal ocout <<  << endl;"
        exe "normal 8h"
    elseif extension == "java"
        exe "normal oSystem.out.println();"
        exe "normal 1h"
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

function! LatexDiap()
    exe "!pdflatex ".expand('%').";
        \ if [ $? -eq 0 ]; then
        \     gnome-open ".expand('%:r').".pdf;
        \ fi"
    exe "!rm -f *.nav *.out *.snm *.toc *.aux *.log"
endfunction

function! Latex()
    exe "!pdflatex ".expand('%').";
        \ if [ $? -eq 0 ]; then
        \     rm -f *.out *.dvi *.blg *.bbl *.aux *.log;
        \     gnome-open ".expand('%:r').".pdf;
        \ fi"
endfunction

function! LatexBib()
    exe "!latex ".expand('%').";
        \ if [ $? -eq 0 ]; then
        \     bibtex ".expand('%:r').".aux;
        \     latex ".expand('%').";
        \     latex ".expand('%').";
        \     pdflatex ".expand('%').";
        \     rm -f *.out *.dvi *.blg *.bbl *.aux *.log;
        \     gnome-open ".expand('%:r').".pdf;
        \ fi"
endfunction
