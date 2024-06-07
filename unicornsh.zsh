# If AI enabled, add a unicorn in front of the prompt
PS1="$(if [[ -n $SCRIPT ]]; then echo '\n🦄 '; fi)$PS1"

export PATH=$PATH:~/.unicornsh/scripts:~/.unicornsh/bin

# Pipe the context into the sgpt command
# ai = sgpt
# s = shell mode
# r = repl mode
# f = function calling
# l = OpenAI gpt4 instead of default model. Consider running a local model for privacy!
# o = Use last 500 lines of output from the shell instead of the default 50

### Model variables
L_MODEL="gpt-4o"
GL_MODEL="groq/llama3-70b-8192"

alias ai='~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias aigl='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --model $GL_MODEL --no-functions $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias aigls='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --model $GL_MODEL --no-functions --shell $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias aigle='aigls "do it"'
alias aiglse='aigls "do it"'
alias aiglf='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --model $GL_MODEL $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias ail='~/.unicornsh/scripts/aicontext.sh | sgpt --model $L_MODEL --no-functions $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias ais='~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --shell $(if [[ -n $AISESSION ]]; then echo "--chat $AISESSION"; fi)'
alias aif='ais "fix this"'
alias air='~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airl='~/.unicornsh/scripts/aicontext.sh | sgpt --model openai/gpt-4-turbo --no-functions --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airf='~/.unicornsh/scripts/aicontext.sh | sgpt --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airfl='~/.unicornsh/scripts/aicontext.sh | sgpt --model openai/gpt-4-turbo --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airfo='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airflo='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --model $L_MODEL --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airglo='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --no-functions --model $GL_MODEL --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias airglow='~/.unicornsh/scripts/aicontext.sh 500 | sgpt --model $GL_MODEL --repl $(if [[ -n $AISESSION ]]; then echo "$AISESSION"; else echo "temp"; fi)'
alias ag='aigle'
alias as='aigls'
alias ae='aiglse'
alias af='airflo'
alias airflow='airflo'

# alias ai="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions"
# alias ais="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --shell"
# alias air="~/.unicornsh/scripts/aicontext.sh | sgpt --no-functions --repl temp"
# alias airf="~/.unicornsh/scripts/aicontext.sh | sgpt --repl temp"
# alias airfl="~/.unicornsh/scripts/aicontext.sh 500 | sgpt --repl temp"

### Other tools
alias aiStartSession='export AISESSION=$(date -u +"%Y-%m-%dT%H:%M:%SZ")'
alias aiStopSession='unset AISESSION'
alias aiShowSession='echo "AISESSION is set to $AISESSION"'
