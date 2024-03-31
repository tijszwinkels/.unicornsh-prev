 # .🦄sh

Welcome to .unicornsh!

This project is a proof of concept for having an LLM assistant in the shell, that has context on what you were working on before it was called.
Uses [shell_gpt](https://github.com/TheR1D/shell_gpt), but adds scripting so the assistant knows the last command that was executed, and the output it received.

This is just a proof-of-concept hacked together with shell scripts. I feel it's already useful, but use at your own risk! Look at the commands that the LLM wants to execute before executing them. Especially the function calling functionality can damage your system if not used with care.

Moreover, be aware that
- by default, for every question to the LLM, the output of the previous command is sent to the OpenAI api. This might not be what you want, especially with proprietary code, secrets, or private information. Consider running a local LLM with ollama.
- Everything in your shell session will now be stored in ~/.🦄sh/logs, which might have security and privacy implications as well.
- Using LLMs costs money. Especially when using GPT4 (l modifier) in long REPL session or when keeping conversation context (`aiStartSession`), this can quickly become expensive. Keep an eye on your [OpenAI usage dashboard](https://platform.openai.com/usage).

### Features:
- 🦄 in your shell prompt.
- All actions on the shell are saved in ~/.🦄sh/logs
- The assistant 'knows' the last command you executed and what the output was
- Optionally keep context / remember over multiple calls to the assistant in the same shell session
- Optionally use function-calling! It's smart enough to read and create its own functions for subsequent use

### Installation
Right now only tried and working on macOS in zsh. Shouldn't be difficult to get running on Linux, but isn't yet.

- Install [shell_gpt](https://github.com/TheR1D/shell_gpt) - Follow the instructions for giving it a OpenAI key and configuring it.

- Run the following:
```
cd ~/ && git clone git@github.com:tijszwinkels/.unicornsh.git && ln -s ~/.unicornsh ~/.🦄sh
echo "source ~/.unicornsh/unicornsh.zsh" >> ~/.zshrc
sgpt --install-functions
rm -r ~/.config/shell_gpt/functions && ln -s ~/.unicornsh/functions ~/.config/shell_gpt/functions
```

- open a new shell

This will allow you to enter .🦄sh by typing `aime`

Optionally; Make every new shell a .🦄sh by adding the following to the end of ~/.zshrc
```
if [[ -z $SCRIPT ]]; then
	aime
fi
```


### Usage:
Enter the .🦄sh by typing:

```
aime
```

Then, a 🦄 is added to the beginning of the shell prompt.

For each of these commands, the last executed shell command + the last 50 lines of the output of that command are added to the prompt that's send to the LLM.

The following commands can be used:

```
# 'ai' to ask questions
ai "Why is this not working?"
```

This will use the model that's configured in *~/.config/shell_gpt/.sgptrc* .
The idea is to have relatively small/cheap model as default (for example, I use a locally running mixtral by default), and add 'l' to use the  To use gpt-4-turbo-preview for more difficult quesstions, for example:


```
# 'ail' for 'larger model'
ail "Explain the output of the last command"
```


This will just answer the question, but it won't try to execute anything. This can be done with `ais` for ai-shell. This will output a command, and ask for confirmation for executing it.

```
# 'ais' for 'ai shell'
ais "Fix the typo in my last command"
# -> sudo softwareupdate -i -a
# -> [E]xecute, [D]escribe, [A]bort: e
```

air starts a REPL (read-eval-print loop) session. Just ask a question and get an answer, like in the normal ChatGPT interface.
The repl interface is useful for debugging, as it will show exactly what's being sent to the LLM.

```
# 'air' for 'REPL mode'
air
Entering REPL mode, press Ctrl+C to exit.
>>> """
... Explain following code:
... import random
... print(random.randint(1, 10))
... """
It is a Python script that uses the random module to generate and print a random integer.
```

Use `airl` for the same, but then using GPT4.

#### Function calling

See the [shell-gpt documentation](https://github.com/TheR1D/shell_gpt?tab=readme-ov-file#function-calling) for more information. With function-calling enabled, the repl-interface will be able to perform actions directly on your system. This is very powerful, but can also be dangerous.

I highly recommend using GPT4 for function calling, as it's less likely to make mistakes that could damage your system.

I modified the default 'shell execution' function to show the shell-function that it will execute before executing it. Confirm with <ENTER>. ctrl-c to cancel execution and exit the REPL interface.

Use `airfl` for entering repl-mode with function-calling enabled (f), using GPT4 (l).

```
# 'airfl' for REPL mode, with function-calling enabled, using GPT4
cat ~/.unicornsh/functions/*
airfl
Entering REPL mode, press Ctrl+C to exit.
>>> Write a new function that opens a variable page in a browser window.

Write a new function that opens a variable page in a browser window.
\`\`\`python
import webbrowser
from pydantic import Field
from instructor import OpenAISchema

class Function(OpenAISchema):
    """
    Opens a specified URL in the default web browser.
    """
    url: str = Field(
        ...,
        example="https://www.example.com",
        descriptions="URL to open in the web browser."
    )

    class Config:
        title = "open_in_browser"

    @classmethod
    def execute(cls, url: str) -> str:
        try:
            webbrowser.open(url)
            return f"Successfully opened {url} in the default web browser."
        except Exception as e:
            return f"Error opening {url} in the web browser: {e}"
\`\`\`
>>> Great. Write it.


> @FunctionCall `write_file(content="import webbrowser
from pydantic import Field
from instructor import OpenAISchema

class Function(OpenAISchema):
    """
    Opens a specified URL in the default web browser.
    """
    url: str = Field(
        ...,
        example="https://www.example.com",
        descriptions="URL to open in the web browser."
    )

    class Config:
        title = "open_in_browser"

    @classmethod
    def execute(cls, url: str) -> str:
        try:
            webbrowser.open(url)
            return f"Successfully opened {url} in the default web browser."
        except Exception as e:
            return f"Error opening {url} in the web browser: {e}"
", file_path="functions/open_in_browser.py")`

Press Enter to confirm execution of the command...```text
Successfully wrote to functions/open_in_browser.py
\`\`\`
>>> ^CAborted.
```

Great, let's see whether that worked. We need to exit (ctrl-c or ctrl-d) and restart the repl interface for it to see the new function.

```
airfl
Entering REPL mode, press Ctrl+C to exit.
>>> Open the page of the guardian

> @FunctionCall `open_in_browser(url="https://www.theguardian.com")`

\`\`\`text
Successfully opened https://www.theguardian.com in the default web browser.
\`\`\`
```

### Chat sessions
By default, each new question or each newly started repl session won't remember what was asked to the AI before.
If you do want to enter a conversation session, run:
```
aiStartSession
```

The conversation will be remembered until it's stopped with:
```
aiStopSession
```

or reset with:
```
aiStartSession
```
again.
