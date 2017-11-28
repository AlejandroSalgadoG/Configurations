au BufNewFile *.tex :call Latex()

function! Haskell()
    exe "normal imain = print()"
endfunction

