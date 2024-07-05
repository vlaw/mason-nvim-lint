local M = {}

---@class MasonNvimLintSettings
local DEFAULT_SETTINGS = {
    -- A list of linters to automatically install if they're not already installed. Example: { "eslint_d", "revive" }
    -- This setting has no relation with the `automatic_installation` setting.
    -- Names of linters should be taken from the mason's registry.
    ---@type string[]
    ensure_installed = {},

    ---@type string[]
    -- just like `zapling/mason-conform.nvim`, this option allows you to ignore certain linters from being installed.
    ignore_install = { },

    -- Whether linters that are set up (via nvim-lint) should be automatically installed if they're not already installed.
    -- It tries to find the specified linters in the mason's registry to proceed with installation.
    -- This setting has no relation with the `ensure_installed` setting.
    ---@type boolean
    automatic_installation = true,

    -- Disables warning notifications about misconfigurations such as invalid linter entries and incorrect plugin load order.
    quiet_mode = false,
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
---@class MasonNvimLintSettings
M.current = M._DEFAULT_SETTINGS

---@param opts MasonNvimLintSettings
function M.set(opts)
    M.current = vim.tbl_deep_extend("force", M.current, opts)
    local ensure_installed = M.current.ensure_installed
    local ignore_install = M.current.ignore_install

    -- Remove ignored linters from the `ensure_installed` list.
    if #ensure_installed > 0 then
        for index, linter in ipairs(ensure_installed) do
            if vim.list_contains(ignore_install, linter) then
                table.remove(ensure_installed, index)
            end
        end
    end
    M.current.ensure_installed = ensure_installed
end

return M
