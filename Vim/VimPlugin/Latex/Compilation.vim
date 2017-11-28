function! PdfLatex()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
        exe "!".g:cmd.expand('%:r')." ".g:args

    elseif filereadable(g:name.".bib")
        echom "Bib"
        exe "normal tt"
        call MakeLatexBibHead()
        call MakeLatexBibClean()
        call MakeLatexExe()
        exe "normal gg"
        write Makefile
        quit
        call PdfLatex()
    else
        exe "normal tt"
        call MakeLatexHead()
        call MakeLatexClean()
        call MakeLatexExe()
        exe "normal gg"
        write Makefile
        quit
        call PdfLatex()
    endif
endfunction

function! MakeLatexHead()
    :call Make()
    exe "normal i".g:name.".pdf: "g:name.".tex\n
        \\tpdflatex ".g:name.".tex\n
        \\trm -f *.nav *.snm *.toc* .out *.dvi *.blg *.bbl *.aux *.log"
endfunction

function! MakeLatexClean()
    exe "normal o\nclean:\n
        \\trm -f ".g:name.".pdf"
endfunction

function! MakeLatexExe()
    exe "normal o\nexe:\n
        \\tmupdf ".g:name.".pdf"
endfunction

function! MakeLatexBibHead()
    :call Make()
    exe "normal i".g:name.".pdf: ".g:name.".tex ".g:name.".bib\n
        \\tlatex ".g:name.".tex\n
        \\tbibtex ".g:name.".aux\n
        \\tlatex ".g:name.".tex\n
        \\tlatex ".g:name.".tex\n
        \\tpdflatex ".g:name.".tex"
endfunction

function! MakeLatexBibClean()
    exe "normal o\ncleanstandar:\n
        \\trm -f *.out *.dvi *.blg *.bbl *.aux *.log *.vrb"

    exe "normal o\nclean:\n
        \\trm -f *.out *.dvi *.blg *.bbl *.aux *.log *.vrb ".g:name.".pdf"
endfunction
