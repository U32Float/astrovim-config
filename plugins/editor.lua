return {{
    "kevinhwang91/nvim-hlslens",
    config = function()
        -- hi default link HlSearchNear IncSearch
        -- hi default link HlSearchLens WildMenu
        -- hi default link HlSearchLensNear IncSearch

        require("hlslens").setup {
            override_lens = function(render, posList, nearest, idx, relIdx)
                local sfw = vim.v.searchforward == 1
                local indicator, text, chunks
                local absRelIdx = math.abs(relIdx)
                if absRelIdx > 1 then
                    indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and "N" or "n")
                elseif absRelIdx == 1 then
                    indicator = sfw ~= (relIdx == 1) and "N" or "n"
                else
                    indicator = ""
                end

                local lnum, col = unpack(posList[idx])
                if nearest then
                    local cnt = #posList
                    if indicator ~= "" then
                        text = ("󰧟[%s %d/%d]"):format(indicator, idx, cnt)
                    else
                        text = ("󰧟[%d/%d]"):format(idx, cnt)
                    end
                    chunks = {{" ", "Ignore"}, {text, "HlSearchLensNear"}}
                else
                    text = ("󰧟[%s %d]"):format(indicator, idx)
                    chunks = {{" ", "Ignore"}, {text, "HlSearchLens"}}
                end
                render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
            end
        }
    end
}, {"rapan931/lasterisk.nvim"}, {
    "dstein64/nvim-scrollview",
    lazy = false,

    config = function()
        require("scrollview").setup {
            excluded_filetypes = {"nerdtree", "alpha"},
            current_only = true,
            winblend = 0,
            base = "right",
            hover = true,
            column = 1,
            signs_on_startup = {"all"},
            diagnostics_severities = {vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR}
        }
    end
}, {
    "anuvyklack/windows.nvim",
    lazy = false,
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false

        require("windows").setup({
            ignore = {
                buftype = {"quickfix", "terminal"}
            }
        })
    end,
    dependencies = {"anuvyklack/middleclass" -- "anuvyklack/animation.nvim" // Bugged
    }
}}
