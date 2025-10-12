return {
  "rbmarliere/get_maintainer.nvim",
  opts = {
    path = "/home/nairda/linux_work/linux/scripts/get_maintainer.pl", -- defaults to get_maintainer.pl, assume it's visible in $PATH
    -- verbose = false, -- enable debugging messages
    -- use_clipboard = "" -- can be unnamed or unnamedplus, where to send the script output
    args = {
      --   "--flags-to-the-script", -- defaults to {"--scm"} to retrieve the trees too
      "--scm",
    },
  },
  config = function(_, opts)
    local get_maintainer = require("get_maintainer")
    get_maintainer.setup(opts)

    -- suggested mappings
    vim.keymap.set("n", "<Leader>M", get_maintainer.from_file, { noremap = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitive" },
      callback = function()
        vim.keymap.set("n", "<Leader>M", get_maintainer.from_cursor, { noremap = true, buffer = true })
        vim.keymap.set("x", "<Leader>M", get_maintainer.from_range, { noremap = true, buffer = true })
      end,
    })
  end,
}
