" function! JavaScriptFold() 
    " setl foldmethod=syntax
    " setl foldlevelstart=20
    " syn region foldBraces start="{" end="}" transparent fold keepend extend

    " function! FoldText()
        " return substitute(getline(v:foldstart), '{.*', '{...}', '')
    " endfunction
    " setl foldtext=FoldText()
" endfunction

" call JavaScriptFold()

" setl foldmethod=marker
" setl foldlevelstart=20
