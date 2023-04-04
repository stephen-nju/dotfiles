--adapter

local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, ui = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok) then
  require("notify")("dap-ui not installed!", "warning")
  return
end

ui.setup({})

-----配置window  cpptools的debug
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/usr/local/opt/llvm/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb',
  command = 'D:\\cpptools-win64\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
    options = {
    detached = false
  }
}

--config

---其他平台cpptools的配置
--dap.adapters.cppdbg = {
--  id = 'cppdbg',
--  type = 'executable',
--  command = 'C:\\absolute\\path\\to\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
--  options = {
--    detached = false
--  }
--}
-- cpptools的配置


--dap.adapters.lldb = {
--  type = 'executable',
--  command = 'D:/msys64/ucrt64/bin/lldb-vscode', -- adjust as needed, must be absolute path
--  name = 'lldb'
--}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
    stopAtEntry = true,
  },
}
--config lldb的配置
--dap.configurations.cpp = {
--  {
--    name = 'Launch',
--    type = 'lldb',
--    request = 'launch',
--    program = function()
--      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--    end,
--    cwd = '${workspaceFolder}',
--    stopOnEntry = false,
--    args = {},
--
--    -- 💀
--    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--    --
--    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--    --
--    -- Otherwise you might get the following error:
--    --
--    --    Error on launch: Failed to attach to the target process
--    --
--    -- But you should be aware of the implications:
--    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--    runInTerminal = false,
--  },
--}
  
  
vim.fn.sign_define('DapBreakpoint', { text = '->' })

----- debug mappings-----
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)


vim.keymap.set({ 'n', 'v' }, '<leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- Close debugger and clear breakpoints
vim.keymap.set("n", "<localleader>de", function()
  dap.clear_breakpoints()
  ui.toggle({})
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
  require("notify")("Debugger session ended", "warn")
end)

dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close({})
end


dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close({})
end


local ok, dap_python = pcall(require, "dap-python")
if not ok then
  require("notify")("dap-ui not installed!", "warning")
  return
end

dap_python.setup('D:/ProgramData/Anaconda3/python')
