" let g:templator_ingnore_priority = 0
" let g:templator_autotemplate = 1

let s:templator_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

if has('win32') || has ('win64')
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif
if !exists('g:templator_ignore_priority')
    let g:templator_ignore_priority = 0
endif
if !exists('g:templator_config_dir')
    let g:templator_config_dir = $VIMHOME . '/template.json'
endif

if !exists('g:templator_autotemplate') || g:templator_autotemplate
    autocmd BufRead * if getfsize(expand('%'))==0 |call TemplatorTemplate()|endif
    autocmd BufNewFile * call TemplatorTemplate()
    " autocmd BufEnter * if getfsize(expand('%'))==0 |call TemplatorTemplate()|endif
endif

python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:templator_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
# sys.path.append(vim.eval('g:templator_template_dir'))
import templator
EOF

function! TemplatorTemplate()
    python3 templator.searchTemplate()
endfunction

function! TemplatorShowSelectTemplatePopup(templates)
    call popup_menu(a:templates, #{
        \ title: "Select template:",
        \ callback: 'TemplatorSelectTemplate',
        \ line: 25,
        \ col: 60,
        \ highlight: 'Question',
        \ border: [],
        \ close: 'click',
        \ padding: [1,1,0,1]
        \})
endfunction

function! TemplatorSelectTemplate(id, result)
    let s:templator_selected_template = a:result
  python3 templator.appendTemplate()
endfunction

command! TemplatorTemplate  call TemplatorTemplate()
