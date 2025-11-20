require "nvchad.options"

-- add yours here!

local o = vim.o

-- Relative line numbers
o.number = true
o.relativenumber = true

-- Highlight current line
o.cursorline = true

-- Which-key delay fix
o.timeoutlen = 400  -- Time to wait for mapped sequence (ms)
o.ttimeoutlen = 10  -- Time to wait for key code sequence (ms)

-- Undo file support (persistent undo)
o.undofile = true
-- Use XDG directory for undo files
o.undodir = vim.fn.stdpath("state") .. "/undo"
