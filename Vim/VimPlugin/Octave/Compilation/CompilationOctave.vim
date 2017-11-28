function! OctaveC()
    let name=expand('%:r')
    if filereadable("Makefile")
        make exe
    else
        exe "normal tt"
        call MakeOctaveExe(name)
        write Makefile
        quit
        call OctaveC()
    endif
endfunction

function! MakeOctaveExe(name)
    :call Make()
    exe "normal iexe: ".a:name.".m\n
        \\toctave -q ".a:name.".m"
endfunction
