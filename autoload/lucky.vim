function lucky#open_model()
  let lucky_output = luaeval('require("src/finders").find_model_file(_A)', expand('%:p'))

  execute 'edit ' . lucky_output
endfunction

function lucky#open_action()
  let lucky_output = luaeval('require("src/finders").find_action_file(_A)', expand('%:p'))

  execute 'edit ' . lucky_output
endfunction

function lucky#open_page()
  let lucky_output = luaeval('require("src/finders").find_page_file(_A)', expand('%:p'))

  execute 'edit ' . lucky_output
endfunction

function lucky#open_operation()
  let lucky_output = luaeval('require("src/finders").find_operation_file(_A)', expand('%:p'))

  execute 'edit ' . lucky_output
endfunction
