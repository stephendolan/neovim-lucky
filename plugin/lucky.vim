if exists('g:lucky_loaded')
  finish
endif

let g:lucky_loaded = 1

command Emodel  :call lucky#open_model()
command Eaction :call lucky#open_action()
command Epage   :call lucky#open_page()
command Eop     :call lucky#open_operation()

