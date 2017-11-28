let column="false"
let indent="false"

noremap H :map<enter>
noremap C :call Column()<enter>
noremap I :call Indent()<enter>
noremap T :tabnew<enter>
noremap S :call Sop()<enter>
noremap <space> :call Clean()<enter>
noremap <F2> :call Javac()<enter>
noremap <F3> :call Ghc()<enter>
noremap <F4> :call LatexBib()<enter>
noremap <F5> :call Latex()<enter>
noremap <F6> :call LatexDiap()<enter>
noremap U <C-R>
noremap W <C-W>


au BufNewFile *.java :call Java()
au BufNewFile *.hs :call Haskell()
au BufNewFile,BufRead Makefile :call Make()

function! Make()
    exe "set noexpandtab"
    exe "normal i\n\nclean:\n	rm -f *.o"
	exe "normal gg"
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

function! Ghc(...)
    echom system("ghc ".expand('%'))
    exe "!if [ $? -eq 0 ]; then
        \   ./".expand('%:r')." ".join(a:000)";
        \   rm -f *hi *.o ".expand('%:r').";
        \ fi"
endfunction

function! Javac(...)
    echom system("javac ".expand('%'))
    exe "!if [ $? -eq 0 ]; then
        \   java ".expand('%:r')." ".join(a:000)";
        \   rm -f *class;
        \ fi"
endfunction

function! Clean()
    exe '%s/\s\+$//'
endfunction

function! Sop()
    exe "normal oSystem.out.println();"
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

function! Java()
    let name=expand('%:r')
    exe "normal ipublic class ".name."{\n\n
        \public ".name."(){\n\n}\n\n
        \public static void main(String[] args){\n
        \".name tolower(name)." = new ".name."();\n
        \}\n
        \}"
endfunction

function! Haskell()
    exe "normal imain = print()"
endfunction
