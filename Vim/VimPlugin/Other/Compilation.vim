function! Other()
    if exists('g:cmd')
        exe "!".g:cmd." ".g:args
    else
        echom "please set a command to execute (F3 may help)"
    endif
endfunction
