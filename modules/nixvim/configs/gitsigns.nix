{
  plugins.gitsigns = {
    enable = true;

    signs = {
      add = { text = "+"; };
      change = { text = "~"; };
      delete = { text = "-"; };
      topdelete = { text = "‾"; };
      changedelete = { text = "~"; };
    };

    # onAttach = {
    #   function = ''
    #               function(bufnr)
    #                 vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })
    #
    #     			-- don't override the built in and fugitive keymaps
    #     			local gs = package.loaded.gitsigns
    #
    #     			vim.keymap.set({ "n", "v" }, "]c", function()
    #     				if vim.wo.diff then
    #     					return "]c"
    #     				end
    #     				vim.schedule(function()
    #     					gs.next_hunk()
    #     				end)
    #     				return "<Ignore>"
    #     			end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
    #     			vim.keymap.set({ "n", "v" }, "[c", function()
    #     				if vim.wo.diff then
    #     					return "[c"
    #     				end
    #     				vim.schedule(function()
    #     					gs.prev_hunk()
    #     				end)
    #     				return "<Ignore>"
    #     			end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
    #
    #     			vim.keymap.set("n", "<leader>gsh", gs.stage_hunk, { desc = "Git stage hunk" })
    #     			vim.keymap.set("n", "<leader>gsb", gs.stage_buffer, { desc = "Git stage buffer" })
    #     			vim.keymap.set("n", "<leader>gsu", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
    #     			vim.keymap.set("n", "<leader>gsr", gs.reset_buffer, { desc = "Git reset buffer" })
    #     			vim.keymap.set("n", "<leader>gsp", gs.preview_hunk, { desc = "Git preview hunk" })
    #
    #     			vim.keymap.set("n", "<leader>gpp", ":Git push ", { desc = "Git push" })
    #     			vim.keymap.set("n", "<leader>gpr", ":Git rebase origin ", { desc = "Git rebase origin" })
    #     			vim.keymap.set("n", "<leader>gi", ":Git<CR>", { desc = "Git interactive" })
    #               end
    #   '';
    # };
  };
}
