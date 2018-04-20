au BufNewFile *.hs call Hs()

let cmd=g:cmd_comp

function! Hs()
    exe "normal imain = print ()"
endfunction
