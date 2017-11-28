let column="false"
let indent="false"
let mouse="true"


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

so ~/Github/Vim/VimPlugin/Cpp/Autocomplete/AutocompleteCpp.vim
so ~/Github/Vim/VimPlugin/Java/Autocomplete/AutocompleteJava.vim
so ~/Github/Vim/VimPlugin/Latex/Autocomplete/AutocompleteLatex.vim
so ~/Github/Vim/VimPlugin/Csharp/Autocomplete/AutocompleteCsharp.vim
so ~/Github/Vim/VimPlugin/Haskell/Autocomplete/AutocompleteHaskell.vim

function! Make()
    set noexpandtab
    set nocindent
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
    let extension=expand('%:e')
    if extension == "C"
        :call PrintCpp()
    elseif extension == "java"
        :call PrintJava()
    elseif extension == "cs"
        :call PrintCsharp()
    endif
endfunction

function! PrintCpp()
    exe "normal ocout <<  << endl;"
    exe "normal 8h"
endfunction

function! PrintJava()
    exe "normal oSystem.out.println();"
    exe "normal 1h"
endfunction

function! PrintCsharp()
    exe "normal oConsole.WriteLine();"
    exe "normal 1h"
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
    let extension=expand('%:e')
    if extension == "C" || extension == "h"
        :call Gpp()
    elseif extension == "java"
        :call Javac()
    elseif extension == "cs"
        :call Gmcs()
    elseif extension == "hs"
        :call Ghc()
    elseif extension == "tex"
        :call PdfLatex()
    endif
endfunction

function! Gpp()
    let name=expand('%:r')
    if filereadable("Makefile")
        make
        make exe
    else
        exe "normal tt"
        call MakeCppHead(name)
        call MakeCppClean(name)
        call MakeCppExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call Gpp()
    endif
endfunction

function! MakeCppHead(name)
    :call Make()
    exe "normal i".a:name.": ".a:name.".o\n
        \\tg++ ".a:name.".o -o ".a:name."\n\n"
        \.a:name.".o: ".a:name.".C\n
        \\tg++ -c ".a:name.".C"
endfunction

function! MakeCppClean(name)
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".a:name
endfunction

function! MakeCppExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction

function! Javac(...)
    let name=expand('%:r')
    if filereadable("Makefile")
        make
        make exe
    else
        exe "normal tt"
        call MakeJavaHead(name)
        call MakeJavaClean(name)
        call MakeJavaExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call Javac()
    endif
endfunction

function! MakeJavaHead(name)
    :call Make()
    exe "normal i".a:name.".class: ".a:name.".java\n
        \\tjavac ".a:name.".java\n"
endfunction

function! MakeJavaClean(name)
    exe "normal o\nclean:\n\trm -f *.class "
endfunction

function! MakeJavaExe(name)
    exe "normal o\nexe:\n\tjava ".a:name
endfunction

function! Gmcs()
    let name=expand('%:r')
    if filereadable("Makefile")
        make
        make exe
    else
        exe "normal tt"
        call MakeCsharpHead(name)
        call MakeCsharpClean(name)
        call MakeCsharpExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call Gmcs()
    endif
endfunction

function! MakeCsharpHead(name)
    :call Make()
    exe "normal i".a:name.": "a:name.".cs\n
        \\tgmcs -out:".a:name." ".a:name.".cs\n\n"
endfunction

function! MakeCsharpClean(name)
    exe "normal o\nclean:\n\trm -f *.dll ".a:name
endfunction

function! MakeCsharpExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction

function! Ghc(...)
    echom system("ghc ".expand('%'))
    exe "!if [ $? -eq 0 ]; then
        \   ./".expand('%:r')." ".join(a:000)";
        \   rm -f *hi *.o ".expand('%:r').";
        \ fi"
endfunction

function! PdfLatex()
    let name=expand('%:r')
    if filereadable("Makefile")
        make
        make cleanstandar
        exe "!gnome-open ".name.".pdf"
    elseif filereadable(name.".bib")
    echom "Bib"
        exe "normal tt"
        call MakeLatexBibHead(name)
        call MakeLatexBibClean(name)
        call MakeLatexExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call PdfLatex()
    else
        exe "normal tt"
        call MakeLatexHead(name)
        call MakeLatexClean(name)
        call MakeLatexExe(name)
	    exe "normal gg"
        write Makefile
        quit
        call PdfLatex()
    endif
endfunction

function! MakeLatexHead(name)
    :call Make()
    exe "normal i".a:name.".pdf: "a:name.".tex\n
        \\tpdflatex ".a:name.".tex"
endfunction

function! MakeLatexClean(name)
    exe "normal o\ncleanstandar:\n
        \\trm -f *.nav *.snm *.toc *.out *.dvi *.blg *.bbl *.aux *.log"

    exe "normal o\nclean:\n
        \\trm -f *.nav *.snm *.toc* .out *.dvi *.blg *.bbl *.aux *.log
        \ ".a:name.".pdf"
endfunction

function! MakeLatexExe(name)
    exe "normal o\nexe:\n
        \\tgnome-open ".a:name.".pdf"
endfunction

function! MakeLatexBibHead(name)
    :call Make()
    exe "normal i".a:name.".pdf: ".a:name.".tex ".a:name.".bib\n
        \\tlatex ".a:name.".tex\n
        \\tbibtex ".a:name.".aux\n
        \\tlatex ".a:name.".tex\n
        \\tlatex ".a:name.".tex\n
        \\tpdflatex ".a:name.".tex"
endfunction

function! MakeLatexBibClean(name)
    exe "normal o\ncleanstandar:\n
        \\trm -f *.out *.dvi *.blg *.bbl *.aux *.log *.vrb"

    exe "normal o\nclean:\n
        \\trm -f *.out *.dvi *.blg *.bbl *.aux *.log *.vrb ".a:name.".pdf"
endfunction
