function! Gcc()
    let name=expand('%:r')
    if filereadable("Makefile")
        make

        for output in getqflist()
            if output.valid == "1"
                return
            endif
        endfor

        exe "!".g:cmd.name." ".g:args
    else
        exe "normal tt"
        call MakeCHead(name)
        call MakeCClean(name)
        call MakeCExe(name)
        exe "normal gg"
        write Makefile
        quit
        call Gcc()
    endif
endfunction

function! MakeCHead(name)
    :call Make()
    exe "normal i".a:name.": ".a:name.".o\n
        \\tgcc ".a:name.".o -o ".a:name."\n\n"
        \.a:name.".o: ".a:name.".c\n
        \\tgcc -c ".a:name.".c"
endfunction

function! MakeCClean(name)
    :call Make()
    exe "normal o\nclean:\n\trm -f *.o ".a:name
endfunction

function! MakeCExe(name)
    exe "normal o\nexe:\n\t./".a:name
endfunction
