source ~/.config/nvim/init.vim

packadd! onedark.vim
" packadd! fzf
" packadd! fzf.vim
packadd! vim-jsx-pretty
" packadd! copilot.vim

" --> Fzf
" source ~/.config/nvim/plugins.conf.d/fzf.vim
" set rtp+=/usr/share/vim/vimfiles

" --> Zeal
source ~/.config/nvim/plugins.conf.d/zeal.vim

" --> Onedark theme
source ~/.config/nvim/plugins.conf.d/onedark.vim

" --> Vimspector
source ~/.config/nvim/plugins.conf.d/vimspector.vim

" --> COC
autocmd! User coc.nvim source $HOME/.config/nvim/plugins.conf.d/coc-onload.vim
let g:coc_config_home = '$HOME/.config/nvim/plugins.conf.d'
let g:coc_data_home = '$HOME/.local/share/nvim/site/coc'
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-marketplace',
            \ 'coc-css',
            \ 'coc-tsserver',
            \ 'coc-pyright',
            \ 'coc-sh',
            \ ]
nnoremap <silent><nowait> <leader>ca  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <leader>cp  :<C-u>CocListResume<CR>
nnoremap <leader>cm :CocList marketplace<CR>
nnoremap <leader>cff :Format<CR>
inoremap <silent><expr><c-l> coc#refresh()

nnoremap <leader><C-r> :source ~/.config/nvim/coc.vim<CR>

AirlineTheme
CocList extensions
