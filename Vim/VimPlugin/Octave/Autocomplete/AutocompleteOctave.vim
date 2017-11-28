au BufNewFile *.m :call Octave()

function! Octave()
    exe "normal ihola"
endfunction
