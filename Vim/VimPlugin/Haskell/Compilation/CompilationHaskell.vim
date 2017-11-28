function! Ghc(...)
    echom system("ghc ".expand('%'))
    exe "!if [ $? -eq 0 ]; then
        \   ./".expand('%:r')." ".join(a:000)";
        \   rm -f *hi *.o ".expand('%:r').";
        \ fi"
endfunction
