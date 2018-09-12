# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/joeltaylor/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/joeltaylor/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/joeltaylor/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/joeltaylor/.fzf/shell/key-bindings.bash"

