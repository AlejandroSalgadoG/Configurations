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
