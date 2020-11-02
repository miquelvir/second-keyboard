--lmc.minimizeToTray = true
--lmc_minimize()

lmc_print_devices()   -- get the ID of the second keyboard from the stack that this line creates
lmc_device_set_name('MACROS1', "ID_1603") -- substitute the ID you have found here
-- lmc_assign_keyboard('MACROS1') -- if Lua doesn't work try adding this line

-- define callback for whole device, assign each key of the keyboard to an imaginary key (usually, keyboards have F1-F12, so we start assigning keys to F13)
lmc_set_handler('MACROS1',function(button, direction)
  if (direction == 1) then return end  -- ignore down; if you want to be able to type the original letters as well with the secondary keyboard, remove this line
  if     (button == string.byte('H')) then lmc_send_keys('{F13}')
  elseif (button == string.byte('A')) then lmc_spawn("calc")
  elseif (button == string.byte('2')) then lmc_send_keys('{F15}')
  elseif (button == string.byte('3')) then lmc_send_keys('{F16}')
  elseif (button == string.byte('4')) then lmc_send_keys('{F17}')
  elseif (button == 90) then lmc_send_keys('^+%{b}') -- once F keys are over, just use combitations with alt, ctrl, shift, win, or tab (https://github.com/me2d13/luamacros/wiki/List-of-Keys)
  -- etc.
  else print('Not yet assigned: ' .. button)
  end
end)

-- if you wanted more keyboards, just repeat line 5 with its id and a assign a new name, like MACROS2.
-- then repeat the code that starts in line 9, but change the name to the one you have just assigned.
-- For exemple, to: lmc_set_handler('MACROS2', ...

