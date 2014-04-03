
" get execute engine of indicated filetype
function! s:GetExecuteEngine(filetype)
    if has_key(g:scriptrunner_filetypes, a:filetype)
        let filetype_dic = g:scriptrunner_filetypes[a:filetype]
        if has_key(filetype_dic, "execute")
            return filetype_dic["execute"]
        endif
    endif
    return ""
endfunction

" get interactive engine of indicated filetype
function! s:GetInteractiveEngine(filetype)
    if has_key(g:scriptrunner_filetypes, a:filetype)
        let filetype_dic = g:scriptrunner_filetypes[a:filetype]
        if has_key(filetype_dic, "interactive")
            return filetype_dic["interactive"]
        endif
    endif
    return ""
endfunction

" preview interpreter's output(refer to Vim's Tip #1244)
function! scriptrunner#preview_script_output() range
    
    let l:engine_name = s:GetExecuteEngine(&filetype)
    if empty(l:engine_name)
        echo "setting no engine"
        return
    endif
    let l:dst = &filetype . " Output"
    let l:engine = ":%! " . l:engine_name . " "

    " make temporary file to write source code
    let l:src = tempname()
    " put current buffer's content in a temp file
    silent execute ": " . a:firstline . "," . a:lastline . "w " . l:src
    " open the preview window
    if &co > 140
        silent execute ":vert bel pedit! " . l:dst
    else
        silent execute ":pedit! " . l:dst
    endif
    " change to preview window
    wincmd P
    " set options
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal syntax=none
    setlocal bufhidden=delete
    " replace current buffer with Io's output
    silent execute l:engine . l:src . " 2>&1 "
    " change back to the source buffer
    wincmd p
    
endfunction

" run script on shell
function! scriptrunner#execute_script_on_shell() range
    let l:engine_name = s:GetExecuteEngine(&filetype)
    if empty(l:engine_name)
        echo "setting no engine"
        return
    endif
    execute ":!" . l:engine_name . " " . expand('%')
endfunction

" run script on interactive
function! scriptrunner#execute_script_on_interactive() range
    let l:engine_name = s:GetInteractiveEngine(&filetype)
    if empty(l:engine_name)
        echo "setting no engine"
        return
    endif
    execute ":VimShellInteractive " . l:engine_name . " " . expand('%')
    " execute ":!" . l:engine_name . " " . expand('%')

    " async execution
    " call vimproc#system(l:engine_name . " " . expand('%'))
endfunction

