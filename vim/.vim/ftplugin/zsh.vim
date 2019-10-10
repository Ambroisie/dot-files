" Use shfmt as ALE fixer for zsh
let b:ale_fixers=[ 'shfmt' ]

" Indent with 4 spaces, simplify script, indent switch cases, use Bash variant
let b:ale_sh_shfmt_options='-i 4 -s -ci -ln bash'

" Use bash dialect explicitly, require explicit empty string test
let b:ale_sh_shellcheck_options='-s bash -o avoid-nullary-conditions'
