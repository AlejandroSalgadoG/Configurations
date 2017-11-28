function! Gmcs()
    let name=expand('%:r')
    if filereadable("Makefile")
        make

        for output in getqflist()
            if output.valid == "1"
                return
            endif
        endfor

        exe "!./".name
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
