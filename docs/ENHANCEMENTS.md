# env-prefix Enhancements

## 1. Multiple Environment Files

### Usage
```bash
envp --env=prod claude
envp --env=dev gpt
```

### Design
- Still prefix-only semantics
- No state switching
- Each invocation is independent
- Files: `~/.env-prefix/<name>.env`

### Example Structure
```
~/.env-prefix/
├── default.env    # Used when no --env specified
├── prod.env       # Production keys
├── dev.env        # Development keys
└── staging.env    # Staging environment
```

## 2. Required Variables Validation

### Usage
Add to your `.env` file:
```bash
export ENV_PREFIX_REQUIRED="OPENAI_API_KEY,ANTHROPIC_API_KEY"
```

### Behavior
- Checks before exec
- Fails fast with clear error
- No partial execution
- Comma-separated list

### Example
```bash
# Missing required var
$ envp claude
Error: Required environment variable 'OPENAI_API_KEY' is not set

# All vars present
$ envp claude
# ✓ Executes normally
```

## 3. POSIX Compatibility + CI

### Changes
- `#!/bin/sh` instead of `#!/usr/bin/env bash`
- Use `.` instead of `source`
- Use `printf` instead of `echo`
- POSIX parameter expansion
- No bash arrays or `[[` tests

### CI Pipeline
- ShellCheck linting
- Multi-shell testing (dash, bash, sh)
- Functional tests
- Command preservation tests

### Benefits
- Works on minimal systems
- Alpine Linux compatible
- Faster execution
- More portable

## Design Principles Maintained

✅ Still prefix-only  
✅ Still one-shot execution  
✅ Still uses exec  
✅ Still zero semantic knowledge  

All enhancements are **additive**, not transformative.

## 4. Profile Prefix via argv0

### Usage
```bash
# Create a prefix command for a profile
ln -s "$(command -v envp)" ~/.local/bin/sonnet

# Runs claude with ~/.env-prefix/sonnet.env injected
sonnet claude
```

### Design
- Keeps "prefix-only" semantics: still just environment injection + exec
- No model/flag knowledge; selection is purely by profile name
- Compatible with `--env=<name>` when you need to override
