return {
  terminal = "kitty" or os.getenv("TERM"),
  editor = os.getenv("EDITOR") or "vi",
  launcher = "rofi -show run",
  browser = "librewolf-bin",
}
