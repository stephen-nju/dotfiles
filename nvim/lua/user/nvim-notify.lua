local status_ok, notify = pcall(require, "notify")
if not status_ok then
  print("notify is not installed")
  return
end
notify.setup({})
vim.notify=notify
