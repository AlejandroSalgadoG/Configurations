au BufNewFile *.hs call Hs()

function! Hs()
    exe "normal imain = print ()"
endfunction
