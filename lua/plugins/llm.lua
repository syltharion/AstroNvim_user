return {
  "Kurama622/llm.nvim",
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  opts = function(_, opts)
    opts = opts or {}
    opts.prompt = "You are a professional programmer."

    ------------------- set your model parameters -------------------
    -- You can choose to configure multiple models as needed.
    -----------------------------------------------------------------

    --- style1: set single model parameters
    opts.url = "https://models.inference.ai.azure.com/chat/completions"
    opts.model = "gpt-4o-mini"
    opts.api_type = "openai"

    -- style2: set parameters of multiple models
    -- (If you need to use multiple models and frequently switch between them.)
    opts.models = {
      {
        name = "ChatGPT",
        url = "https://models.inference.ai.azure.com/chat/completions",
        model = "gpt-4o-mini",
        api_type = "openai",
      },
      {
        name = "ChatGLM",
        url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
        model = "glm-4-flash",
        api_type = "zhipu",
        max_tokens = 8000,
        fetch_key = function() return vim.env.GLM_KEY end,
        temperature = 0.3,
        top_p = 0.7,
      },
    }
    return opts
  end,
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>ac"] = { "<CMD>LLMSessionToggle<CR>", desc = "Toggle LLM.nvim session" },
          },
        },
      },
    },
  },
}
