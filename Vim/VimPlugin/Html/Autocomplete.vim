au BufNewFile *.html :call Html()

set tabstop=2
set shiftwidth=2
set expandtab

function! Html()
    set nocindent
    exe "normal i<!DOCTYPE html>\n
        \<html>\n
        \  <head>\n
        \  </head>\n\n
        \  <body>\n
        \  </body>\n
        \</html>"
    set cindent
endfunction
