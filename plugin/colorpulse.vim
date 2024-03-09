" colorpulse.vim

" don't load twice
if exists("g:loaded_colorpulse") || &cp || v:version < 700
  finish
endif
let g:loaded_colorpulse = 1

function! ColorPulsePrev()
  echom "ColorPulsePrev"
endfunction

function! ColorPulseNext()
  echom "ColorPulseNext"
endfunction

command! -nargs=0 ColorPulsePrev call ColorPulsePrev()
command! -nargs=0 ColorPulseNext call ColorPulseNext()

nmap <silent> [c :ColorPulsePrev<CR>
nmap <silent> ]c :ColorPulseNext<CR>
