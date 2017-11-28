au BufNewFile *.tex :call Latex()

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
