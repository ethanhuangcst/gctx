# ctxg

Context sync tool - 整理对话上下文并同步到 GitHub Gist

用于多台设备使用 TRAE、Cursor、Claude Code 等 AI 工具时，整理对话上下文并同步到工程本地文件夹和 GitHub Gist 中。

## 安装

```bash
# 全局安装
npm install -g ctxg

# 或使用 npx（无需安装）
npx ctxg --help
```

## 快速开始

```bash
# 1. 配置 GitHub Token
ctxg config --token ghp_your_token_here

# 2. 同步上下文
ctxg sync

# 3. 查看笔记列表
ctxg list
```

## 命令

### `sync` (别名: `s`) - 同步上下文

```bash
ctxg sync [options]
# 或简写
ctxg s

选项:
  -p, --project <name>  指定项目名称（默认从当前目录提取）
  -d, --dir <path>      指定笔记存储目录
```

### `list` (别名: `l`) - 列出笔记

```bash
ctxg list [options]
# 或简写
ctxg l

选项:
  -p, --project <name>  筛选指定项目的笔记
  -l, --local           只显示本地笔记
```

### `config` (别名: `c`) - 配置

```bash
ctxg config [options]
# 或简写
ctxg c

选项:
  -t, --token <token>   设置 GitHub Token
  -s, --show            显示当前配置
```

### `init` (别名: `i`) - 初始化项目

```bash
ctxg init
# 或简写
ctxg i
```

## 获取 GitHub Token

1. 访问 https://github.com/settings/tokens/new
2. Note: `ctxg`
3. Expiration: 选择 `Custom` → 设置 1 年后
4. Select scopes: ✅ `gist`
5. 点击 Generate token，复制保存

## 目录结构

```
~/.ctxg/                       # 全局配置目录
├── config.json                # 配置文件（Token）
└── gist-mapping.json          # 项目-Gist 映射

your-project/
└── ctxg-notes/                # 本地笔记
    ├── context_2026-03-20.json
    └── ...
```

## 跨工具支持

| 工具 | 使用方式 |
|------|---------|
| TRAE CN | `npx ctxg sync` |
| Cursor | `npx ctxg sync` |
| Claude Code | `npx ctxg sync` |
| 终端 | `ctxg sync` |

## 故障排除

| 问题 | 解决方案 |
|------|---------|
| Token 未配置 | 运行 `ctxg config --token <your-token>` |
| 笔记位置错误 | 检查项目根目录下的 `ctxg-notes/` |
| Gist 上传失败 | 检查 Token 权限和有效期；本地笔记仍可用 |

---

**GitHub**: https://github.com/ethanhuangcst/gctx
