" --> Vimspector
let g:vimspector_base_dir = expand('$HOME/.local/share/nvim/vimspector')
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <leader>dc  <Plug>VimspectorContinue
nnoremap <leader>ds  <Plug>VimspectorStop
nnoremap <leader>dr  <Plug>VimspectorRestart
nnoremap <leader>dp  <Plug>VimspectorPause
nnoremap <leader>dl  <Plug>VimspectorBreakpoints
nnoremap <leader>dd  <Plug>VimspectorToggleBreakpoint
nnoremap <leader>db  <Plug>VimspectorToggleConditionalBreakpoint
nnoremap <leader>df  <Plug>VimspectorAddFunctionBreakpoint
nnoremap <leader>dg  <Plug>VimspectorGoToCurrentLine
nnoremap <leader>dx  :call vimspector#ClearBreakpoints()<CR>
nnoremap <leader>dq  :VimspectorReset<CR>
nnoremap <A-C>       <Plug>VimspectorContinue
nnoremap <A-n>       <Plug>VimspectorStepOver
nnoremap <A-i>       <Plug>VimspectorStepInto
nnoremap <A-o>       <Plug>VimspectorStepOut
nnoremap <A-b>       <Plug>VimspectorToggleBreakpoint
nnoremap <A-c>       <Plug>VimspectorRunToCursor

