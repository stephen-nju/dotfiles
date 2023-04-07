-- https://github.com/ggandor/lightspeed.nvim
local ok, leap = pcall(require, "leap")
if not ok then
    if PLUGIN_MISSING_NOTIFY then
        print('"ggandor/leap.nvim" not available')
    end
    return
end
leap.add_default_mappings()

