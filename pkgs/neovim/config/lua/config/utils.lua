function CloseAllFloatingWindows()
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win_id)
    if config.relative ~= '' and vim.api.nvim_win_is_valid(win_id) then
      vim.api.nvim_win_close(win_id, true)
    end
  end
end

vim.api.nvim_create_user_command('ClearFloating', CloseAllFloatingWindows, { desc = 'Close all floating windows' })
