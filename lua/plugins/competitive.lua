return {
  "xeluxee/competitest.nvim",
  -- event = "VeryLazy",
  lazy = true,
  dependencies = "MunifTanjim/nui.nvim",
  opts = function(_, opts)
    opts.local_config_file_name = ".competitest.lua"
    opts.floating_border = "rounded"
    opts.floating_border_highlight = "FloatBorder"
    opts.picker_ui = {
      width = 0.2,
      height = 0.3,
      mappings = {
        focus_next = { "j", "<down>", "<Tab>" },
        focus_prev = { "k", "<up>", "<S-Tab>" },
        close = { "<esc>", "<C-c>", "q", "Q" },
        submit = "<cr>",
      },
    }
    opts.editor_ui = {
      popup_width = 0.4,
      popup_height = 0.6,
      show_nu = true,
      show_rnu = false,
      normal_mode_mappings = {
        switch_window = { "<C-h>", "<C-l>", "<C-i>" },
        save_and_close = "<C-s>",
        cancel = { "q", "Q" },
      },
      insert_mode_mappings = {
        switch_window = { "<C-h>", "<C-l>", "<C-i>" },
        save_and_close = "<C-s>",
        cancel = "<C-q>",
      },
    }
    opts.runner_ui = {
      interface = "popup",
      selector_show_nu = false,
      selector_show_rnu = false,
      show_nu = true,
      show_rnu = false,
      mappings = {
        run_again = "R",
        run_all_again = "<C-r>",
        kill = "K",
        kill_all = "<C-k>",
        view_input = { "i", "I" },
        view_output = { "a", "A" },
        view_stdout = { "o", "O" },
        view_stderr = { "e", "E" },
        toggle_diff = { "d", "D" },
        close = { "q", "Q" },
      },
      viewer = {
        width = 0.5,
        height = 0.5,
        show_nu = true,
        show_rnu = false,
      },
    }
    opts.popup_ui = {
      total_width = 0.8,
      total_height = 0.8,
      layout = {
        { 4, "tc" },
        { 5, { { 1, "so" }, { 1, "si" } } },
        { 5, { { 1, "eo" }, { 1, "se" } } },
      },
    }
    opts.split_ui = {
      position = "right",
      relative_to_editor = true,
      total_width = 0.3,
      vertical_layout = {
        { 1, "tc" },
        { 1, { { 1, "so" }, { 1, "eo" } } },
        { 1, { { 1, "si" }, { 1, "se" } } },
      },
      total_height = 0.4,
      horizontal_layout = {
        { 2, "tc" },
        { 3, { { 1, "so" }, { 1, "si" } } },
        { 3, { { 1, "eo" }, { 1, "se" } } },
      },
    }

    opts.save_current_file = true
    opts.save_all_files = false
    opts.compile_directory = "."
    opts.compile_command = {
      c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "./bin/$(FNOEXT)" } },
      cpp = { exec = "g++", args = { "-std=c++17", "-Wall", "$(FNAME)", "-o", "./bin/$(FNOEXT)" } },
      rust = { exec = "rustc", args = { "./bin/$(FNAME)" } },
      java = { exec = "javac", args = { "./bin/$(FNAME)" } },
    }
    opts.running_directory = "./bin"
    opts.run_command = {
      c = { exec = "./$(FNOEXT)" },
      cpp = { exec = "./$(FNOEXT)" },
      rust = { exec = "./$(FNOEXT)" },
      python = { exec = "python", args = { "$(FNAME)" } },
      java = { exec = "java", args = { "$(FNOEXT)" } },
    }
    opts.multiple_testing = -1
    opts.maximum_time = 5000
    opts.output_compare_method = "squish"
    opts.view_output_diff = false
    opts.testcases_directory = "./testcases"
    opts.testcases_use_single_file = false
    opts.testcases_auto_detect_storage = true
    opts.testcases_single_file_format = "$(FNOEXT).testcases"
    opts.testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt"
    opts.testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt"
    opts.companion_port = 27121
    opts.receive_print_message = true
    opts.start_receiving_persistently_on_setup = false
    opts.template_file = "./templates/template.$(FEXT)"
    opts.evaluate_template_modifiers = true
    opts.date_format = "%c"
    opts.received_files_extension = "cpp"
    opts.received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)"
    opts.received_problems_prompt_path = true
    opts.received_contests_directory = "$(CWD)/contests"
    opts.received_contests_problems_path = "./contests/$(PROBLEM).$(FEXT)"
    opts.received_contests_prompt_directory = true
    opts.received_contests_prompt_extension = true
    opts.open_received_problems = true
    opts.open_received_contests = true
    opts.replace_received_testcases = false
    return opts
  end,
}
