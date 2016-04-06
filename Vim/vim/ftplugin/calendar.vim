function! QuitCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    execute "q"
    unlet g:calendar_open
  else
    execute "q"
  end
endfunction
map <buffer> c :call QuitCalendar()<CR>
