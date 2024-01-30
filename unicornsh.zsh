# If AI enabled, add a unicorn in front of the prompt
PS1="$(if [[ -n $SCRIPT ]]; then echo '🦄 '; fi)""$PS1"

export PATH=$PATH:~/.unicornsh/scripts

# Pipe the context into the sgpt command
alias ai="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions"
alias ais="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --shell"
alias air="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --repl temp"
alias airf="~/.unicornsh/scripts/aicontext.sh | sgpt --repl temp"
alias airfl="~/.unicornsh/scripts/aicontext.sh 500 | sgpt --repl temp"
