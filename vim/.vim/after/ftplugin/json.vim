if !exists("b:undo_ftplugin")
    let b:undo_ftplugin=''
endif

" Use my desired ALE fixer for JSON
let b:ale_fixers=[ 'jq' ]
let b:undo_ftplugin.='|unlet b:ale_fixers'
