-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- require "utils.folding"

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'java',
--   callback = function()
--     vim.cmd('normal! zR')           -- 展开所有折叠
--     vim.cmd([[g/^import /normal! zc]]) -- 只折叠 import 区块
--   end
-- })
-- 自动格式化C++文件
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "c",
--   callback = function()
--     -- 保存时自动格式化
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = 0,
--       command = "ClangFormat",
--     })
--     -- 设置快捷键手动格式化 (例如 <leader>f)
--     vim.keymap.set("n", "<leader>lF", "<cmd>ClangFormat<CR>", { buffer = 0 })
--   end,
-- })

-- 确保与editorconfig兼容
vim.g.clang_format_fallback_style = "LLVM"
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    -- -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
    -- vim.api.nvim_buf_set_keymap(
    --   0,
    --   "n",
    --   "<F7>",
    --   "<ESC>:w<CR>:vsplit<CR>:te gcc-12 -std=c11 -Wshadow -Wall -o %:t:r.out % -g  && time ./%:t:r.out<CR>i",
    --   { silent = true, noremap = true }
    -- )
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F7>",
      "<ESC>:w<CR>:vsplit<CR>:te clang++ -std=c++11 -Wshadow -Wall -o %:t:r.out % -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG && time ./%:t:r.out<CR>i",
      { silent = true, noremap = true }
    )
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "n",
      "<F7>",
      ":w<CR>:vsplit<CR>:te time python3 %<CR>i",
      { silent = true, noremap = true }
    )
  end,
})

local resession = require "resession"
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Always save a special session named "last"
    resession.save "linux"
    resession.save "NvimConfig"
  end,
})

-- 防止进入的时候处于中文输入法
if vim.fn.has "mac" == 1 then vim.cmd ":silent :!/opt/homebrew/bin/macism com.apple.keylayout.ABC" end

-- 为这个函数创建一个用户命令，方便在命令行调用
-- vim.api.nvim_create_user_command('InsertAgenda', insert_today_agenda, { desc = '插入今日日历日程到当前文件' })

-- 声明全局变量 Snacks（假设 Snacks 是一个全局可用的模块）
local Snacks = _G.Snacks or {}

local function insert_today_agenda(opts)
  local force_update = opts and opts.force or false
  -- 定义 icalbuddy 命令
  local ical_command = 'icalbuddy -nc -ps " | " -b "- " -po "datetime,title" -eep notes,url,today eventsToday'
  local agenda_output = vim.fn.systemlist(ical_command)
  if vim.v.shell_error ~= 0 then
    Snacks.notify.warn "Error: 无法获取今日日程。"
    agenda_output = { "未能获取今日日程。" }
  end
  -- 查找 "## Today" 标题行
  local title_pattern = "^## Today"
  local title_line = nil
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for i, line in ipairs(lines) do
    if line:match(title_pattern) then
      title_line = i
      break
    end
  end

  if not title_line then
    Snacks.notify.warn "未找到 '## Today' 标题，无法插入今日日程。"
    return
  end

  -- 计算要删除的旧日程范围
  local start_delete = title_line + 1
  local end_delete = #lines
  if lines[start_delete] and lines[start_delete]:match "^%s*$" then start_delete = start_delete + 1 end

  -- 寻找下一个标题，确定删除的结束位置
  for i = start_delete, #lines do
    if lines[i]:match "^## " then
      end_delete = i - 1 -- 不包含下一个标题
      if lines[end_delete] and lines[end_delete]:match "^%s*$" then end_delete = end_delete - 1 end
      break
    end
  end

  -- 删除旧日程（如果存在）
  if start_delete <= end_delete or force_update then
    vim.api.nvim_buf_set_lines(0, start_delete - 1, end_delete, false, {})
  end

  -- 插入新日程
  vim.api.nvim_buf_set_lines(0, start_delete - 1, start_delete - 1, false, agenda_output)
  Snacks.notify.info "今日日程已更新。"
end -- 插入今日日程函数

-- 用户命令
vim.api.nvim_create_user_command(
  "UpdateAgenda",
  function(opts) insert_today_agenda { force = opts.bang } end,
  { desc = "更新今日日程", bang = true }
)

-- 自动命令
local auto_agenda_group = vim.api.nvim_create_augroup("AutoAgenda", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = auto_agenda_group,
  pattern = "*/Diary/*/*/*.md",
  callback = function()
    local filename = vim.fn.expand "%:t"
    local filepath = vim.fn.expand "%:p"
    local today = os.date "%d"
    if filename == today .. ".md" and filepath:match("/Diary/.+/" .. today .. "%.md$") then
      vim.defer_fn(function() insert_today_agenda() end, 100)
    end
  end,
})

