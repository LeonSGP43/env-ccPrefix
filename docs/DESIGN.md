# env-prefix Design Principles

## 1. Prefix, not wrapper

envp must never alter command behavior. It only injects environment variables.

## 2. One-shot execution

All environment variables live only in the child process tree.

## 3. exec or nothing

All commands must be executed via exec to preserve:
- signals
- stdin/stdout
- interactive behavior

## 4. Zero semantic knowledge

envp does not know:
- what "claude" is
- what "gpt" is
- what flags mean

It may optionally choose the env profile by:
- `--env=<name>`
- the invoked program name (argv0) when `envp` is symlinked/copied as `<name>`
