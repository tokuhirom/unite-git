" unite source for `git ls-files`
" LICENSE: Public Domain
" AUTHOR: Tokuhiro Matsuno

let s:source = {
\   'name': 'git',
\ }

function! s:source.on_init(args, context)
    let s:buffer = {
        \ }
endfunction

function! s:create_candidate(val)
    return {
    \   "word": a:val,
    \   "source": "git",
    \   "kind": "file",
    \   "action__path": a:val,
    \   "action__directory": unite#path2directory(a:val)
    \ }
endfunction

function! s:source.gather_candidates(args, context)
    let lines = split(system("git ls-files --cached --others"), "\n")
    return filter(map(lines, 's:create_candidate(v:val)'), 'len(v:val) > 0')
endfunction

function! unite#sources#git#define()
  return [s:source]
endfunction

