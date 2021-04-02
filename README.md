# Neovim Configuration
My personal neovim configuration

To use 
1) backup your ~/.config/nvim
2) clone the repo to `git clone git@github.com:drocha87/neovim.git ~/.config/nvim`

## Install vim plug
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Start nvim and run `:PlugInstall`

## Install COC languages (LSP)

`:CocInstall coc-go`


