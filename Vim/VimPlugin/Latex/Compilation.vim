function! PdfLatex()
    let name=expand('%:r')
    if filereadable("Makefile")
        make

        for output in getqflist()
            if output.valid == "1"
                return
            endif
        endfor

        exe "!mupdf ".name.".pdf"

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
        \\tpdflatex ".a:name.".tex\n
        \\trm -f *.nav *.snm *.toc* .out *.dvi *.blg *.bbl *.aux *.log"
endfunction

function! MakeLatexClean(name)
    exe "normal o\nclean:\n
        \\trm -f ".a:name.".pdf"
endfunction

function! MakeLatexExe(name)
    exe "normal o\nexe:\n
        \\tmupdf ".a:name.".pdf"
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
