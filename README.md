# env-prefix

让 Claude Code CLI 支持多模型并行编辑的环境切换工具。

## 问题

Claude Code CLI 默认只能用一个模型。想同时用 Sonnet 和 Opus？想对比不同模型的输出？做不到。

## 解决方案

一次配置，永久使用。通过环境前缀快速切换模型：

```bash
claude "写个函数"           # 默认模型
sonnet claude "写个函数"    # Sonnet 模型
opus claude "写个函数"      # Opus 模型
```

多个终端窗口，不同模型，并行编辑。充分发挥 Claude Code 的能力。

## 系统要求

- macOS
- Claude Code CLI 已安装

## 安装

```bash
git clone https://github.com/your-org/env-prefix.git
cd env-prefix
./install.sh
```

**⚠️ 重要**：如果看到 PATH 警告，执行以下命令：

```bash
# zsh 用户（macOS 默认）
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# bash 用户
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

执行后，重启终端或运行 `source ~/.zshrc` 即可使用。

## 配置模型

### Sonnet (AWS Bedrock)

`config/sonnet.env`：
```bash
export CLAUDE_CODE_USE_BEDROCK=1
```

### Opus (AWS Bedrock)

`config/opus.env`：
```bash
export CLAUDE_CODE_USE_BEDROCK=1
export CLAUDE_MODEL="claude-opus-4-20250514"
```

### 其他模型

`config/mymodel.env`：
```bash
export CLAUDE_CODE_USE_BEDROCK=1
export CLAUDE_MODEL="your-model-id"
```

## 使用

```bash
# 默认模型
claude "帮我重构这个函数"

# Sonnet 模型
sonnet claude "帮我重构这个函数"

# Opus 模型
opus claude "帮我重构这个函数"
```

### 并行编辑

打开多个终端窗口，用不同模型同时工作：

```bash
# 终端 1 - Sonnet 快速迭代
sonnet claude "优化性能"

# 终端 2 - Opus 深度思考
opus claude "设计架构"

# 终端 3 - 默认模型
claude "写测试"
```

## 添加新模型

```bash
# 1. 创建配置（文件名 = 命令名）
cp config/sonnet.env.template config/gpt4.env
vim config/gpt4.env

# 2. 更新
./install.sh

# 3. 使用
gpt4 claude "你的问题"
```

## 优势

- **一次配置，永久使用**：配置保存在 `~/.env-prefix/`，重启不失效
- **快速切换**：一个前缀，切换模型
- **并行编辑**：多个终端，不同模型，同时工作
- **不污染环境**：环境变量只在子进程生效
- **简单直接**：文件名就是命令名

## 工作原理

1. `sonnet` 命令检查 `~/.env-prefix/sonnet.env`
2. 加载环境变量（如 `CLAUDE_CODE_USE_BEDROCK=1`）
3. 执行原生 `claude` 命令
4. 环境变量只在这次执行中生效

## 更新配置

```bash
vim config/sonnet.env
./install.sh
```

## 常见问题

**Q: 重启后还能用吗？**  
A: 能！配置永久保存在 `~/.env-prefix/`，只要 PATH 设置正确。

**Q: 如何删除模型？**  
A: 删除 `config/mymodel.env`，运行 `./install.sh`

**Q: 支持其他系统吗？**  
A: 目前只支持 macOS，脚本是 POSIX 兼容的，理论上可以在 Linux 使用。

**Q: 会影响其他 claude 命令吗？**  
A: 不会。只有带前缀的命令才会加载环境变量。
