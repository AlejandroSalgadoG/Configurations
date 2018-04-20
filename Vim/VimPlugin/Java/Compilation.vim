function! Javac()
    if filereadable("Makefile")
        exe "!make ".g:mkargs
        if v:shell_error
            return
        endif
        exe "!".g:cmd." ".g:args
    else
        exe "normal tt"
        call MakeJavaHead()
        call MakeJavaClean()
        call MakeJavaExe()
        exe "normal gg"
        write Makefile
        quit
        call Javac()
    endif
endfunction

function! MakeJavaHead()
    :call Make()
    exe "normal i".g:name.".class: ".g:name.".java\n
        \\tjavac ".g:name.".java\n"
endfunction

function! MakeJavaClean()
    exe "normal o\nclean:\n\trm -f *.class "
endfunction

function! MakeJavaExe()
    exe "normal o\nexe:\n\tjava ".g:name
endfunction
