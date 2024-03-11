" colorpulse.vim

" don't load twice
if exists("g:loaded_colorpulse") || &cp || v:version < 700
  finish
endif
let g:loaded_colorpulse = 1

let s:colors = split(globpath(&rtp, 'colors/*.vim'), '\n')
let s:colorsLength = len(s:colors)

function! GetColorSchemeName()
  let current_scheme = get(g:, 'colors_name', 'default')
  return current_scheme
endfunction

function! GetColorSchemeIndex()
  let current_scheme = GetColorSchemeName()
  let current_index = indexof(s:colors, { i,v -> v =~# current_scheme . '\.vim$' })
  return current_index
endfunction

function! ShortSchemeName(scheme)
  let current_scheme_only_name = fnamemodify(a:scheme, ':t:r')
  return current_scheme_only_name
endfunction

function! ColorPulse()
  let current_scheme = GetColorSchemeName()
  let current_index = GetColorSchemeIndex()
  let current_scheme_only_name = ShortSchemeName(current_scheme)
  echom  '(' .  current_index . '/' . s:colorsLength . ') ' . current_scheme
endfunction

function! ColorPulseAll()
  echom s:colors
endfunction

function! ColorPulseNext()
  let next_index = (GetColorSchemeIndex() + 1) % s:colorsLength
  let next_scheme = s:colors[next_index]
  echom  '(' .  next_index . '/' . (s:colorsLength - 1) . ') ' . ShortSchemeName(next_scheme)
  execute 'colorscheme' fnameescape(fnamemodify(next_scheme, ':t:r'))
endfunction

function! ColorPulsePrev()
  let prev_index = (GetColorSchemeIndex() - 1) % s:colorsLength
  if (prev_index < 0)
    let prev_index = s:colorsLength - 1
  endif
  let prev_scheme = s:colors[prev_index]
  echom  '(' .  prev_index . '/' . (s:colorsLength - 1) . ') ' . ShortSchemeName(prev_scheme)
  execute 'colorscheme' fnameescape(fnamemodify(prev_scheme, ':t:r'))
endfunction

command! -nargs=0 ColorPulse call ColorPulse()
command! -nargs=0 ColorPulseAll call ColorPulseAll()
command! -nargs=0 ColorPulsePrev call ColorPulsePrev()
command! -nargs=0 ColorPulseNext call ColorPulseNext()

nmap <silent> [c :ColorPulsePrev<CR>
nmap <silent> ]c :ColorPulseNext<CR>
