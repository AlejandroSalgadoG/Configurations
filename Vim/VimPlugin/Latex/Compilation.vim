function! PdfLatex()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
    else
        if filereadable(expand('%:r').".bib")
            exe "normal tt"
            call MakeLatexBibHead()
        else
            exe "normal tt"
            call MakeLatexHead()
        endif

        call MakeLatexClean()
        call MakeLatexExe()
        write Makefile
        quit
        call PdfLatex()
    endif
endfunction

function! MakeLatexHead()
    :call Make()
    exe "normal i".g:name.".pdf: "g:name.".tex\n
        \\tpdflatex ".g:name.".tex"
endfunction

function! MakeLatexClean()
    exe "normal o\nclean:\n
        \\trm -f ".g:name.".pdf\n
        \\trm -f *.nav *.snm *.toc* .out *.dvi *.blg *.bbl *.aux *.log"
endfunction

function! MakeLatexExe()
    exe "normal o\nexe:\n
        \\tevince ".g:name.".pdf &"
endfunction

function! MakeLatexBibHead()
    :call Make()
    exe "normal i".g:name.".pdf: ".g:name.".tex ".g:name.".bib\n
        \\tpdflatex ".g:name.".tex\n
        \\tbibtex ".g:name."\n
        \\tpdflatex ".g:name.".tex\n
        \\tpdflatex ".g:name.".tex\n
        \\tpdflatex ".g:name.".tex"
endfunction
