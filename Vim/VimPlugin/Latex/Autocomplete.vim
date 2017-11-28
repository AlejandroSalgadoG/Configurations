au BufNewFile *.tex :call Latex()

let cmd="evince "
noremap T :call Itemize()<enter>

function! Latex()
    set nocindent
    exe "normal i\\documentclass{article}\n\n
        \\\usepackage[utf8]{inputenc}\n\n
        \\\begin{document}\n\n
        \    \\title{}\n
        \    \\author{}\n
        \    \\date{}\n\n
        \    \\maketitle\n\n
        \\\end{document}"
    set cindent
endfunction

function! Itemize()
    exe "normal o\\begin{itemize}\n
        \\t\\item\n
        \\b\\end{itemize}"
endfunction
