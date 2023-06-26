local M = {
	terminal = "kitty" or os.getenv("TERM"),
	editor = os.getenv("EDITOR") or "nvim",
  browser = "firefox",
	rofi_cmd = "rofi -show run",
}

return M
