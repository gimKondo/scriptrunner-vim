" File: scriptrunner.vim
" Version: 1.0
" Author: gim_kondo
" Description: 
" <global variables>
" g:scriptrunner_filetypes
"
" <mapping>
" save and run script on shell
"   xmap <silent> <Plug>(scriptrunner-on_priview)
"   nmap <silent> <Plug>(scriptrunner-on_priview)
"
" save and run script on shell
"   nmap <silent> <Plug>(scriptrunner-on_shell)

" save and run script on interactive
"   nmap <silent> <Plug>(scriptrunner-interactive)
"
" Last Modified: 2014 Feb 25

if exists("loaded_script_runner") | finish | endif
let loaded_script_runner=1



if !exists('g:scriptrunner_filetypes')
  let g:scriptrunner_filetypes = {}
endif
  

" run script, and output the result
xnoremap <silent> <Plug>(scriptrunner-on_priview) :call scriptrunner#preview_script_output()<CR><C-w>=
nmap <silent> <Plug>(scriptrunner-on_priview) mzggVG<F10>`z

" save and run script on shell
nnoremap <silent> <Plug>(scriptrunner-on_shell) :w<CR>:call scriptrunner#execute_script_on_shell()<CR>

" save and run script on interactive
" old <C-S-F10>
nnoremap <silent> <Plug>(scriptrunner-interactive) :w<CR>:call scriptrunner#execute_script_on_interactive()<CR>

