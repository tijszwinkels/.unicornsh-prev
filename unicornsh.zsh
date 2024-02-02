# If AI enabled, add a unicorn in front of the prompt
PS1="$(if [[ -n $SCRIPT ]]; then echo '🦄 '; fi)$PS1"

export PATH=$PATH:~/.unicornsh/scripts

# Pipe the context into the sgpt command
alias ai='~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias ais='~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --shell $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias air='~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airf='~/.unicornsh/scripts/aicontext.sh | sgpt --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airfl='~/.unicornsh/scripts/aicontext.sh | sgpt --model gpt-4-turbo-preview --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airfo='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airflo='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --model gpt-4-turbo-preview --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'


# alias ai="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions"
# alias ais="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --shell"
# alias air="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --repl temp"
# alias airf="~/.unicornsh/scripts/aicontext.sh | sgpt --repl temp"
# alias airfl="~/.unicornsh/scripts/aicontext.sh 500 | sgpt --repl temp"

### Other tools
alias aiStartSession='export AISESSION=$(date -u +"%Y-%m-%dT%H:%M:%SZ")'
alias aiStopSession='unset AISESSION'
alias aiShowSession='echo "AISESSION is set to $AISESSION"'