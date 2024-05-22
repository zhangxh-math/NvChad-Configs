require "nvchad.mappings"

-- 现有映射
vim.api.nvim_set_keymap('n', '<leader>ss', '<cmd> set spell!<CR>', { noremap = true, silent = true })

-- 添加Inkscape的映射
vim.api.nvim_set_keymap('i', '<C-f>', '<Esc>: silent exec \'.!inkscape-figures create "\'.getline(\'.\').\'" "\'.b:vimtex.root.\'/figures/"\'<CR><CR>:w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ': silent exec \'!inkscape-figures edit "\'.b:vimtex.root.\'/figures/" > /dev/null 2>&1 &\'<CR><CR>:redraw!<CR>', { noremap = true, silent = true })

-- 将 <C-s> 映射为保存文件的快捷键
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>gv', { noremap = true, silent = true })


-- 使用 map 设置键映射
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- 在正常模式下使用 Ctrl+Shift+v 粘贴
vim.api.nvim_set_keymap('n', '<C-S-v>', '"+p', { noremap = true, silent = true })

-- -- 在插入模式下使用 Ctrl+Shift+v 粘贴
vim.api.nvim_set_keymap('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })

-- 在插入模式下使用 Ctrl+z 进行撤销
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })

-- -- 在插入模式下使用 Ctrl+Shift+z 进行重做
vim.api.nvim_set_keymap('i', '<C-S-z>', '<C-o><C-r>', { noremap = true, silent = true })
--
-- -- 设置执行完撤销和重做后仍然保持在插入模式下
-- vim.cmd('autocmd InsertLeave * startinsert')


-- 可选：多模式下的保存映射
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
