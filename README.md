# env-prefix

一个命令，切换环境。不污染 shell。

## 安装

```bash
git clone https://github.com/your-org/env-prefix.git
cd env-prefix
./install.sh
```

**重要**：如果提示需要添加 PATH，运行：

```bash
# zsh 用户
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# bash 用户
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

这样重启后也能用。

## 使用

```bash
claude              # 直接用 claude
sonnet claude       # 用 sonnet 环境的 claude
```

## 添加新环境

### 1. 创建配置文件

**文件名 = 命令名**

```bash
# 想用 myenv 命令？创建 myenv.env
cp config/sonnet.env.template config/myenv.env

# 想用 prod 命令？创建 prod.env
cp config/sonnet.env.template config/prod.env

# 编辑配置
vim config/myenv.env
```

### 2. 更新到全局

```bash
./install.sh
```

### 3. 使用

```bash
myenv claude    # 用 myenv.env 的配置
prod claude     # 用 prod.env 的配置
```

## 配置示例

### AWS Bedrock

`config/sonnet.env`：
```bash
export CLAUDE_CODE_USE_BEDROCK=1
```

### OpenAI

`config/gpt.env`：
```bash
export OPENAI_API_KEY="sk-xxxx"
```

### 自定义环境变量

`config/myenv.env`：
```bash
export MY_API_KEY="xxx"
export MY_REGION="us-west-1"
export ENV_PREFIX_REQUIRED="MY_API_KEY"  # 必需变量校验
```

## 工作原理

1. `myenv` 命令检查是否存在 `~/.env-prefix/myenv.env`
2. 存在 → 加载环境变量，执行后面的命令
3. 不存在 → 直接执行命令

环境变量只在子进程生效，不影响当前 shell。

## 常见问题

**Q: 重启后还能用吗？**  
A: 能！配置文件在 `~/.env-prefix/`，符号链接在 `~/.local/bin/`，都是永久的。只要 PATH 设置正确就行。

**Q: 如何更新配置？**  
A: 编辑 `config/*.env`，然后运行 `./install.sh`

**Q: 如何删除环境？**  
A: 删除 `~/.env-prefix/myenv.env` 和 `~/.local/bin/myenv`

**Q: 配置文件在哪？**  
A: 项目里：`config/*.env`，全局：`~/.env-prefix/*.env`
