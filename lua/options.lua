require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local g = vim.g
local opt = vim.opt

opt.wrap = true
opt.relativenumber = true
g["loaded_python3_provider"] = nil
g["python3_host_prog"] = '/usr/bin/python3'
