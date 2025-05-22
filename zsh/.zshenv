export HISTFILE="${ZDOTDIR}/.zsh_history"
export HISTFILESIZE=1000
export HISTSIZE=100

export TMPDIR="/tmp"

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"

export PYTHON_HISTORY="${XDG_STATE_HOME}/python_history"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"
export PYTHONUSERBASE="${XDG_DATA_HOME}/python"

export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmfvar"
export TEXMFCONFIG="${XDG_CONFIG_HOME}/texlive/texmf-config"

export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

[ -d "~/.local/share/cargo/bin" ] && export PATH="~/.local/share/cargo/bin:${PATH}"
