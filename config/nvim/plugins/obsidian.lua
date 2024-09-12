local obsidian = require("obsidian")
obsidian.setup({
      workspaces = {
        {
          name = "main",
          path = "~/Documents/Main",
        },
      },
      notes_subdir = "01 - Rough Notes",
      daily_notes = {
	 folder = "notes/dailies",
	-- Optional, if you want to change the date format for the ID of daily notes.
	date_format = "%DD.%mmm.%YYYY",
	-- Optional, if you want to change the date format of the default alias of daily notes.
	template = "Daily Note.md"
      },

      completion = {
	nvim_cmp =  true,
	min_chars = 3,
      },
	mappings = {
	    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
	    ["gf"] = {
	    action = function()
		return obsidian.gf_passthrough()
	    end,
	    opts = { noremap = false, expr = true, buffer = true },
	    },
	    -- Toggle check-boxes.
	    ["<leader>ch"] = {
	    action = function()
		return obsidian.toggle_checkbox()
	    end,
	    opts = { buffer = true },
	    },
	    -- Smart action depending on context, either follow link or toggle checkbox.
	    ["<cr>"] = {
	    action = function()
		return obsidian.smart_action()
	    end,
	    opts = { buffer = true, expr = true },
	    }
	},
    new_notes_location = "04 - Main Notes",
    templates = {
	folder = "06 - Templates",
	date_format = "%DD.%MMM.%YYYY",
	time_format = "%H:%M",
	-- A map for custom variables, the key should be the variable and the value a function
	substitutions = {},
    },
    picker = {
	name = "telescope.nvim",
	note_mappings = {
	new = "<C-x>",
	insert_link = "<C-l>",
	},
    },
    ui = {
	enable = true,  -- set to false to disable all additional syntax features
	update_debounce = 200,  -- update delay after a text change (in milliseconds)
	max_file_length = 5000,  -- disable UI features for files with more than this many lines
	-- Define how various check-boxes are displayed
	checkboxes = {
	-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
	[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
	["x"] = { char = "", hl_group = "ObsidianDone" },
	[">"] = { char = "", hl_group = "ObsidianRightArrow" },
	["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
	["!"] = { char = "", hl_group = "ObsidianImportant" },
	-- Replace the above with this if you don't have a patched font:
	-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
	-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

	-- You can also add more custom ones...
	},
	    -- Use bullet marks for non-checkbox lists.
	bullets = { char = "•", hl_group = "ObsidianBullet" },
	external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
	-- Replace the above with this if you don't have a patched font:
	-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
	reference_text = { hl_group = "ObsidianRefText" },
	highlight_text = { hl_group = "ObsidianHighlightText" },
	tags = { hl_group = "ObsidianTag" },
	block_ids = { hl_group = "ObsidianBlockID" },
	hl_groups = {
	-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
	ObsidianTodo = { bold = true, fg = "#f78c6c" },
	ObsidianDone = { bold = true, fg = "#89ddff" },
	ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
	ObsidianTilde = { bold = true, fg = "#ff5370" },
	ObsidianImportant = { bold = true, fg = "#d73128" },
	ObsidianBullet = { bold = true, fg = "#89ddff" },
	ObsidianRefText = { underline = true, fg = "#c792ea" },
	ObsidianExtLinkIcon = { fg = "#c792ea" },
	ObsidianTag = { italic = true, fg = "#89ddff" },
	ObsidianBlockID = { italic = true, fg = "#89ddff" },
	ObsidianHighlightText = { bg = "#75662e" },
	},
    },
})
