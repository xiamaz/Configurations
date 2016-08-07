setlocal shiftwidth=2 expandtab softtabstop=2
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
nnoremap <buffer> c :call ToggleCalendar()<CR>
