"  --> Fzf

let g:fzf_history_dir = system('echo "${XDG_STATE_HOME:-$HOME/.local/state}/fzf/fzf_vim_history')

let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, {'options': ['--info=inline', '--preview', 'preview {}']}, <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Fzf keybindings
nnoremap <leader>fh  :History<CR>
nnoremap <leader>ff  :Files<CR>
nnoremap <leader>f.  :Files %:p:h<CR>

