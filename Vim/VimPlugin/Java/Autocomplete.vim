au BufNewFile *.java :call Java()

let cmd="java"
let args="%:r"

function! Java()
    let name=expand('%:r')
    exe "normal ipublic class ".name."{\n\n
        \public ".name."(){\n\n}\n\n
        \public static void main(String[] args){\n\n
        \}\n
        \}"
    exe "normal gg"
    exe "normal w"
endfunction
