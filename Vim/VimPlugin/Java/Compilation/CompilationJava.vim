function! Javac()
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