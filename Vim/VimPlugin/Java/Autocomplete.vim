au BufNewFile *.java :call Java()

let cmd=g:cmd_comp

function! Java()
    exe "normal ipublic class ".g:name."{\n\n
        \public ".g:name."(){\n\n}\n\n
        \public static void main(String[] args){\n\n
        \}\n
        \}"
    exe "normal gg"
    exe "normal w"
endfunction
