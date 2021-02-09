# vim-templator
This is a very simple plugin.
It matches the full path of a file using a regular expression
and executes any custom command when the file is opened.
This allows you to create templates of any complexity!

## installation
```viml
Plug 'Skrip42/vim-templator'
```

## config
create template config file (default is .vim/template.json)

configuration file is a simple file that contains an array of an object like
```json
{
    "pattern":"regexp pattern is matched full path of the open file",
    "priority":"priority of the current pattern, with the same priorities, templator will give you a choice",
    "command":"command geing executed",
    "comment":"name of template to be displayed"
}
```
example:
```json
{
    "pattern":"\\.json",
    "priority":0,
    "command":"0r !echo {}",
    "comment":"json base"
}
```
you can see more examples here https://github.com/Skrip42/vimConfig/blob/master/template.json
you also can see my template scripts for example https://github.com/Skrip42/vimConfig/tree/master/templates

## options
```viml
" whether to start automatically when opening an empty file
let g:templator_autotemplete

" set 1 to always show all template options
let g:templator_ignore_priority = 0

" where is template config file
let g:templator_config_dir = '.vim/template.json'
```
