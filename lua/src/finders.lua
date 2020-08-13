-- Returns the components of a full file path, namely:
-- - Path
-- - File
-- - Extension
local function split_filename(filename)
  return string.match(filename, "(.-)([^/]-([^/%.]+))$")
end

-- Given a file extension, determine whether the file is a Crystal file
local function is_crystal_file(file_extension)
  return file_extension == 'cr'
end

-- Quit if we weren't given a Crystal file
local function verify_crystal_file(extension)
  if not is_crystal_file(extension) then
    error 'Not in a Crystal file'
  end
end

-- Given a model name, build up the Lucky model file name
local function model_file_for(model_name)
  return 'src/models/' .. model_name .. '.cr'
end

local function operation_file_for(model_name)
  return 'src/operations/save_' .. model_name .. '.cr'
end

-- Given a path, extract the last component of the path
local function last_path_component(path)
  local last_path_element = nil

  for path_component in string.gmatch(path, '([^/]+)') do
    last_path_element = path_component
  end

  return last_path_element
end

-- Given a string, strip the "s" and call it singular
-- This will need to be much more robust in the future
local function singular(text)
  return string.sub(text, 1, -2)
end

-- Determine whether or not a given path is a Lucky page file
local function is_page_file(full_path)
  local pattern = 'src/pages/.+'

  return string.match(full_path, pattern) ~= nil
end

-- Determine whether or not a given path is a Lucky action file
local function is_action_file(full_path)
  local pattern = 'src/actions/.+'

  return string.match(full_path, pattern) ~= nil
end
-- Determine whether or not a given path is a Lucky operation file
local function is_operation_file(full_path)
  local pattern = 'src/operations/.+'

  return string.match(full_path, pattern) ~= nil
end

local function find_model_file(current_file)
  -- Extract the components from the given file
  local path, filename, extension = split_filename(current_file)

  verify_crystal_file(extension)

  -- Quit if we aren't in a valid directory to look up  a model
  -- Otherwise, look up the model
  if is_page_file(path) then
    model_name = singular(last_path_component(path))
  elseif is_action_file(path) then
    model_name = singular(last_path_component(path))
  elseif is_operation_file(path) then
    model_name = singular(last_path_component(path))
  else
    error 'Not in a page, action, or operation file.'
  end

  -- Return the file to open
  return string.gsub(path, "src/.+", model_file_for(model_name))
end

local function find_operation_file(current_file)
  -- Extract the components from the given file
  local path, filename, extension = split_filename(current_file)

  verify_crystal_file(extension)

  -- Quit if we aren't in a valid directory to look up a model
  -- Otherwise, look up the model
  if is_page_file(path) then
    model_name = singular(last_path_component(path))
  elseif is_action_file(path) then
    model_name = singular(last_path_component(path))
  elseif is_operation_file(path) then
    model_name = singular(last_path_component(path))
  else
    error 'Not in a page, action, or operation file.'
  end

  -- Return the file to open
  return string.gsub(path, "src/.+", operation_file_for(model_name))
end

local function find_action_file(current_file)
  -- Extract the components from the given file
  local path, filename, extension = split_filename(current_file)

  verify_crystal_file(extension)

  -- Quit if we aren't in a valid directory to look up an action
  -- Otherwise, find the action file
  if is_page_file(path) then
    action_path = string.gsub(path, "pages", "actions")
    action_file = string.gsub(filename, "_page", "")

    return action_path .. action_file
  else
    error 'Not in a page file.'
  end
end

local function find_page_file(current_file)
  -- Extract the components from the given file
  local path, filename, extension = split_filename(current_file)

  verify_crystal_file(extension)

  -- Quit if we aren't in a valid directory to look up a page
  -- Otherwise, find the page file
  if is_action_file(path) then
    page_path = string.gsub(path, "actions", "pages")
    page_file = string.gsub(filename, ".cr", "_page.cr")

    return page_path .. page_file
  else
    error 'Not in an action file.'
  end
end

return {
  find_model_file = find_model_file,
  find_action_file = find_action_file,
  find_page_file = find_page_file,
  find_operation_file = find_operation_file,
}
