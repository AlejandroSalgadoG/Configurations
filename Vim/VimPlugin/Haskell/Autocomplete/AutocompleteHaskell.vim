au BufNewFile *.hs :call Haskell()

function! Haskell()
    exe "normal imain = print()"
endfunction

