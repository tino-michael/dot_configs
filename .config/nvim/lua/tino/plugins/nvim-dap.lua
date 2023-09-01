return {
    -- Debug Adapter Protocol client implementation for Neovim
    'mfussenegger/nvim-dap',

    dependencies={
        -- vs-code like UI
        "rcarriga/nvim-dap-ui",
        -- python debug plugin
        'mfussenegger/nvim-dap-python',
        -- persist breakpoints
        {
            'Weissle/persistent-breakpoints.nvim',
            opts = {
                save_dir = vim.fn.stdpath('data') .. '/dap_breakpoints/',
                -- when to load the breakpoints? "BufReadPost" is recommanded.
                load_breakpoints_event = "BufReadPost" ,
                -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
                perf_record = false,
                -- perform callback when loading a persisted breakpoint
                on_load_breakpoint = nil,
            }
        }
    },

    -- only enable if called
    lazy = true,

    keys = {
        -- loading launch.json file
        {"<F2>", function()
                require'dap.ext.vscode'.load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
            end, mode="n"},

        {"<F3>", function()
                require('dapui').toggle()
            end, mode="n"},

        -- setting breakpoints
        {"<F4>", function()
                -- require'dap'.toggle_breakpoint()
                require('persistent-breakpoints.api').toggle_breakpoint()
            end, mode="n"},
        {"<F16>", function()
                require('persistent-breakpoints.api').set_conditional_breakpoint()
            end, mode="n"},

        -- start or continue debug session
        {"<F5>", function()
            local ft = vim.api.nvim_buf_get_option(0, 'filetype')
            if ft == 'rust' then
                vim.cmd.RustDebuggables()
            else
                -- loading launch.json file
                require'dap.ext.vscode'.load_launchjs(nil, { cppdbg = {'c', 'cpp'} })
                require'dap'.continue()
            end
            end, mode="n"},

        -- restart last debug session F17 = shift+F5
        {"<F17>", function()
                require'dap'.run_last()
            end, mode="n"},

        -- step over call
        {"<F6>", function()
                require'dap'.step_over()
            end, mode="n"},

        -- step into function call
        {"<F7>", function()
                require'dap'.step_into()
            end, mode="n"},

        -- step ouf of function call
        {"<F8>", function()
                require'dap'.step_out()
            end, mode="n"},

        -- stop debugging session
        {"<F9>", function()
                require'dap'.close()
            end, mode="n"},
    },

    config = function()

        local dap, dapui = require("dap"), require("dapui")

        dap.adapters.lldb = {
            type = 'executable',
            command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
            name = 'lldb'
        }

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = '/home/tino/Downloads/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
        }

        dap.configurations.cpp = {
            {
                name = 'Launch C++ (generic)',
                type = 'cppdbg',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                setupCommands = {
                    {
                        text = '-enable-pretty-printing',
                        description =  'enable pretty printing',
                        ignoreFailures = false
                    },
                },
            }
        }

        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        require('dap-python').setup()

        --
        -- DAP UI setup
        --
        dapui.setup()

        -- automatically open dap ui on initializing debug session
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        -- do NOT automatically close ui when programme finishes / debug session ends
        dap.listeners.before.event_terminated["dapui_config"] = function()
            -- dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            -- dapui.close()
        end

    end
}
