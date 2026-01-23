# env-prefix

极简的 CLI 环境变量前缀注入器，用于在不污染 shell 的情况下切换环境配置。

## 快速开始

```bash
# 1. 克隆项目
git clone https://github.com/your-org/env-prefix.git
cd env-prefix

# 2. 配置 AWS（如果使用 Bedrock）
aws configure

# 3. 编辑配置文件
vim config/sonnet.env

# 4. 一键安装
./install.sh

# 5. 使用
claude              # 直接使用 claude
sonnet claude       # 使用 sonnet 环境配置
```

## 配置模板

### AWS Bedrock 配置（推荐）

编辑 `config/sonnet.env`：

```bash
# 启用 AWS Bedrock
export CLAUDE_CODE_USE_BEDROCK=1

# AWS 配置（可选，如果已运行 aws configure 则无需设置）
# export AWS_ACCESS_KEY_ID="your-key-id"
# export AWS_SECRET_ACCESS_KEY="your-secret-key"
# export AWS_DEFAULT_REGION="us-west-1"

# 必需变量校验（可选）
# export ENV_PREFIX_REQUIRED="CLAUDE_CODE_USE_BEDROCK"
```

### OpenAI API 配置

编辑 `config/gpt.env`：

```bash
# OpenAI API Key
export OPENAI_API_KEY="sk-xxxx"

# 必需变量校验（可选）
# export ENV_PREFIX_REQUIRED="OPENAI_API_KEY"
```

## 更新配置

```bash
# 1. 编辑配置文件
vim config/sonnet.env

# 2. 重新运行安装脚本
./install.sh
```

## 工作原理

- `claude` → 直接执行原生 claude（无环境配置）
- `sonnet claude` → 加载 `~/.env-prefix/sonnet.env`，然后执行原生 claude
- 环境变量仅在子进程中生效，不污染父 shell

## 使用示例

```bash
claude                    # 直接使用
sonnet claude             # 使用 AWS Bedrock
sonnet claude --resume    # 参数透传
```

## POSIX 兼容

完全兼容 POSIX 标准，适用于 Linux、macOS、BSD 及任何符合 POSIX 标准的系统。
