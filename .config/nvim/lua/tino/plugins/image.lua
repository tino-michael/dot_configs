return {
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        config = function()
            require('image').setup({
                backend = "kitty",
                integrations = {
                    markdown = {
                        only_render_image_at_cursor = true,
                        resolve_image_path = function(document_path, image_path, fallback)
                            return fallback(document_path, image_path)
                        end,
                    },
                    html = {
                        enabled = true,
                    },
                    css = {
                        enabled = true,
                    },
                },
                -- render image files as images when opened
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
            })
        end
    }
}
