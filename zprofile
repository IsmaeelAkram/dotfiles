# devcontainers/cli#1320: buildx >=0.37.2 bake rejects the CLI generated Dockerfile outside the compose context
export BUILDX_BAKE_ENTITLEMENTS_FS=0

if [[ $OSTYPE == darwin* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Added by Toolbox App
  export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

  # Added by OrbStack: command-line tools and integration
  # This won't be added again if you remove it.
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
