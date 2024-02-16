" enables text wrapping for markdown files
:set wrap
:set syntax=markdown

" optional stuff for marksman if I have it installed
" Actually need this for setting the syntax to markdown after
" if exists('g:loaded_lsp')
"   call LspAddServer([#{ name: 'marksman', filetype: ['markdown'], path: '/path/to/marksman', args: ['server'], syncInit: v:true }])
" end

" sets the vim syntax to markdown mode
" why this isn't done automatically is not very clear to me

