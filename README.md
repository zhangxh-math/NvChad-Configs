# NvChad-Configs

## Install
At first, install NvChad and reomve the nvim filefolder
```
rm -rf ~/.config/nvim
```
Then clone this repository
```
git clone git@gitea.zxhmath.com:zhangxh/NvChad-Configs.git ~/.config/nvim
```
Run the following command in the terminal
```
yay -S xclip python3 python-neovim luarocks nodejs unzip tree-sitter-cli ripgrep xdotool npm lazygit
```
Remember to run `:MasonInstallAll` and if you use NvChad for latex, run `:TSIstall latex`.

If the backward search does not work, run `\lc`.
