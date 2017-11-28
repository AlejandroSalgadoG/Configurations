au BufNewFile *.cs :call Csharp()

function! Csharp()
    let name=expand('%:r')
    exe "normal iusing System;\n"
    exe "normal opublic class ".name."{\n\n
        \public static void Main(string[] args){
        \\n\n
        \}\n\n
        \}"
    exe "normal 3k"
    exe "normal i\t\t"
endfunction
