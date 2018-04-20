au BufNewFile *.cs :call Csharp()

let cmd=g:cmd_comp

function! Csharp()
    exe "normal iusing System;\n"
    exe "normal opublic class ".g:name."{\n\n
        \public static void Main(string[] args){
        \\n\n
        \}\n\n
        \}"
    exe "normal 3k"
    exe "normal i\t\t"
endfunction
