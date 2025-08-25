
local kmap = vim.keymap

-- key binding modes
local nv_mode = { "n", "v" }
local n_mode = "n"
local v_mode = "v"

-- ENUM modes
local MODE = {
	NORMAL = 0,
	PYTHON = 1,
	JULIA = 2
}

-- session:window.pane
local BINDED = false
local TMUX_ID = "0:0.1"
local TMUX_MODE = MODE.NORMAL


-- set tmux target pane from nvim
vim.api.nvim_create_user_command("SX", function(opts)
  local arg_list = opts.fargs
  if #arg_list ~= 3 then
    print("Usage: :SX <session> <window> <pane>")
    return
  end

  local session, window, pane = arg_list[1], arg_list[2], arg_list[3]
  TMUX_ID = string.format("%s:%s.%s", session, window, pane)

  print("Tmux target pane set to: " .. TMUX_ID)
  BINDED = true
end, {
  nargs = "+",
})

----------------------------------------------------------------
----------------------------------------------------------------
-- set tmux mode for REPLS
-------------------------------------
vim.api.nvim_create_user_command("SM", function(opts)
	local arg_list = opts.fargs
	if #arg_list ~= 1 then
		print("Usage: :SM <n|p|j>")
	return
	end

	local mode = arg_list[1]
	local mode_name = ""

	if mode == "n" then TMUX_MODE = MODE.NORMAL; mode_name = "NORMAL"
	elseif mode == "p" then TMUX_MODE = MODE.PYTHON; mode_name = "PYTHON"
	elseif mode == "j" then TMUX_MODE = MODE.JULIA; mode_name = "JULIA"
	else
    	print("Invalid mode: " .. mode .. ". Allowed: j, b, p")
    	return
 	end

	print("Tmux mode set to: " .. mode_name)

end, {
  nargs = 1,
})

-- key binding shortcut
-------------------------------------
kmap.set(nv_mode, "<leader>smp", ":SM p<CR>", { desc = "" })
kmap.set(nv_mode, "<leader>smn", ":SM n<CR>", { desc = "" })
kmap.set(nv_mode, "<leader>smj", ":SM j<CR>", { desc = "" })

------------------------------------------------------------------

------------------------------
-- LINE TRACKING
------------------------------
-- line tracking
local IS_TRACKING = false
local TRACKED_LINES = {0, 0}
local last_col = nil

-- Save the cursor column at start of insert
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    last_col = pos[2]  -- 0-indexed column
  end
})

-- Attach buffer listener
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    vim.api.nvim_buf_attach(args.buf, false, {
      on_lines = function(_, _, _, firstline, lastline, new_lastline, _)
      	if not IS_TRACKING then return end

        local delta = new_lastline - lastline
        if delta == 0 then return end

        -- shift only if cursor was at column 0 before edit
        if TRACKED_LINES[1] > firstline and last_col == 0 then
          TRACKED_LINES[1] = TRACKED_LINES[1] + delta
        end
        if TRACKED_LINES[2] > firstline then
          TRACKED_LINES[2] = TRACKED_LINES[2] + delta
        end
      end
    })
  end
})

vim.api.nvim_create_user_command("STe", function(opts)

  TRACKED_LINES = vim.tbl_map(tonumber, opts.fargs)
  
  vim.print("Set TRACKED_LINES to: "..TRACKED_LINES[1].." "..TRACKED_LINES[2])
  IS_TRACKING = true

end, {
  nargs = "+",
})

vim.api.nvim_create_user_command("STo", function()
  vim.print(TRACKED_LINES)
end, {})
vim.api.nvim_create_user_command("STx", function()
  vim.print("Stoped Tracking")
  IS_TRACKING = false
end, {})
------------------------------
-- HELPER FUNCTIONS
------------------------------
function strip(line)
	return line:match("^%s*(.-)%s*$")
end
function lstrip(line)
	return line:match("^%s*(.*)$")
end

function simple_process(text)
	if text == "end" then 
		text = "end "
	end

	-- if TMUX_MODE ~= MODE.PYTHON then
	-- 	text = text:gsub("\\", "\\\\")
	-- end

	return text:gsub("'", "'\\''")
end

-------------------------------
-- CHECK FOR COPY MODE
-------------------------------
function exit_copy_mode()
	local check_cmd = string.format(
		"tmux display-message -p -t %s '#{pane_in_mode}'",
		TMUX_ID
	)
	local handle = io.popen(check_cmd)
	local result = handle:read("*a")
	handle:close()

	result = strip(result)

	if result == "1" then
  	os.execute(string.format("tmux send-keys -t %s q", TMUX_ID))
  end

end

------------------------------
-- UTILITY FUNCTIONS
------------------------------
function clear_terminal()
	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	exit_copy_mode()
	os.execute(string.format(
		[[tmux send-keys -t %s C-l]],
		TMUX_ID
	))
end

function clear_input()
	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	os.execute(string.format(
		[[tmux send-keys -t %s C-u]], -- $'\x15'
		TMUX_ID
	))
end

function hault()
	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	os.execute(string.format(
		[[tmux send-keys -t %s C-c]], -- $'\x15'
		TMUX_ID
	))
end

function enter()
	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	os.execute(string.format(
		[[tmux send-keys -t %s C-m]],
		TMUX_ID
	))
end

function keypress(key_name)
	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	os.execute(string.format(
		[[tmux send-keys -t %s %s]],
		TMUX_ID,
		key_name
	))
end

-- function n_execute(line)
-- 	local cmd = string.format(
-- 		[[tmux send-keys -t %s $'%s' C-j]],
-- 		TMUX_ID,	
-- 		line
-- 	)
-- 	-- local escaped = line:gsub("'", [["'"']])
-- 	-- local cmd = string.format([[tmux send-keys -t %s '%s' Enter]], TMUX_ID, escaped)
-- 	os.execute(cmd)
-- end

function l_execute(line)

	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	if TMUX_MODE == MODE.JULIA then
		line = lstrip(line)
		if line:sub(-1) == ";" then
			line = line .. " "
		end
	end

	local cmd = string.format(
		[[tmux send-keys -t %s -l '%s']],
		TMUX_ID,
		line
	)

	os.execute(cmd)
	keypress("C-m")
end

function get_selected_linenum()
	if not BINDED then 
		print("Set Tmux mode by :SX <session> <window> <pane>")
		return
	end

	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	return start_line, end_line
end

function run_lines(start_line, end_line)
	exit_copy_mode()
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	for _, line in ipairs(lines) do

		if TMUX_MODE == MODE.PYTHON then
			keypress('Home')
		end

		line = simple_process(line)	
		l_execute(line)

	end

end

------------------------------
-- CORE FUNCTIONS
------------------------------
function send_line()
	local line = vim.api.nvim_get_current_line()
	line = simple_process(line)
	
	exit_copy_mode()

	l_execute(line)
	
end

function send_selection()
	local start_line, end_line = get_selected_linenum()

	run_lines(start_line, end_line)
end

function run_tracked_line()

	if not IS_TRACKING then 
		vim.print("First set tracking line to activate...")
		return 
	end

	run_lines(TRACKED_LINES[1], TRACKED_LINES[2])
end





------------------------------
-- KEY BINDING
------------------------------
kmap.set(n_mode, "<leader>e", send_line, { desc = "" })
kmap.set(v_mode, "<leader>e", send_selection, { desc = "" })

kmap.set(nv_mode, "<leader>cl", clear_input, { desc = "" })

-- for halting process
kmap.set(nv_mode, "<leader>h", hault, { desc = "" })

-- press enter
kmap.set(nv_mode, "<leader>r", enter, { desc = "" })
-- press backspace
kmap.set(nv_mode, "<leader>bs", function() keypress("C-h") end, { desc = "" })

-- clearing the window
kmap.set(nv_mode, "<leader>cc", clear_terminal, { desc = "" })

-- line tracking
kmap.set(nv_mode, "<leader>re", run_tracked_line, { desc = "Run tracked lines" })
kmap.set(nv_mode, "<leader>so", ":STo<CR>", { desc = "Show tracked lines" })
kmap.set(nv_mode, "<leader>sx", ":STx<CR>", { desc = "Stop tracking lines" })
kmap.set(v_mode, "<leader>se", 
	function() 
		local st, ed = get_selected_linenum()
		TRACKED_LINES = {st, ed}
		IS_TRACKING = true
		vim.print("Set TRACKED_LINES to: "..st.." "..ed)
	end, { desc = "Set Lines for tracking" })






