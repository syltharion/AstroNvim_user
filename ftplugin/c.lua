if next(vim.fs.find("CMakeLists.txt", { upward = true, stop = vim.fn.getcwd() })) ~= nil then
  -- vim.opt_local.makeprg = "cmake --build build"
  vim.opt.makeprg = [[cmake --build build/Debug]]
  -- vim.opt_local.errorformat = "%f:%l: %m"
end
