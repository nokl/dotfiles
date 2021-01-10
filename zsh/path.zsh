# GCP
export CLOUDSDK_PYTHON=python3
# The next line updates PATH for the Google Cloud SDK.
source '/Users/na-takahashi/google-cloud-sdk/path.zsh.inc'
# The next line enables shell command completion for gcloud.
source '/Users/na-takahashi/google-cloud-sdk/completion.zsh.inc'

# PHP
export PATH="/usr/local/opt/php@7.3/bin:$PATH"
export PATH="/usr/local/opt/php@7.3/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="~/.composer/vendor/bin:$PATH"

# Python
# pyenvさんに~/.pyenvではなく、/usr/loca/var/pyenvを使うようにお願いする
# 参考: https://qiita.com/crankcube/items/15f06b32ec56736fc43a
export PYENV_ROOT=/usr/local/var/pyenv
# pyenv の自動補完機能を有効化
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# AWS
export PATH="/Users/na-takahashi/.ebcli-virtual-env/executables:$PATH"
#export PATH=/Users/na-takahashi/.pyenv/versions/3.7.2/bin:$PATH

# NODE
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# .nvmrc が存在している場合自動でバージョンを切り替える。
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Starship
export STARSHIP_CONFIG=$SCRIPT_DIR/starship/starship.toml