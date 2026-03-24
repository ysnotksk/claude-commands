# Claude Code Commands

Custom [slash commands](https://docs.anthropic.com/en/docs/claude-code/tutorials/slash-commands) for [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview).

## Available Commands

### Research

| Command | Language | Description |
|---------|----------|-------------|
| `/researcher-en` | English | Generate comprehensive researcher profiles with full publication lists, methodology details, and footnoted sources. Supports forward lookup (name → profile) and reverse lookup (concept → researchers). |
| `/researcher-jp` | Japanese | 研究者のプロフィール・全研究実績を体系的にまとめたドキュメントを生成。正引き（研究者名→プロフィール）と逆引き（概念名→研究者）に対応。 |

### Proofreading

| Command | Language | Description |
|---------|----------|-------------|
| `/proofread-en` | English | Proofread English text using vale (write-good, proselint) for mechanical style checks and Claude for context-dependent analysis. |
| `/proofread-jp` | Japanese | MeCab 形態素解析を使った日本語校正。文体混在・重複表現・助詞誤用・長文等を検出。 |
| `/proofread-mode` | English | Detect writing mode (technical/academic/creative/business/literary), then proofread, elaborate, and improve text. |

### Image Generation

| Command | Language | Description |
|---------|----------|-------------|
| `/nanobanana` | English | Generate images using Google Gemini (`gemini-2.5-flash-image`). |
| `/imagen` | English | Generate images using Google Cloud Imagen 4.0. |

### Problem Solving

| Command | Language | Description |
|---------|----------|-------------|
| `/delphi-method` | English | Simulate the Delphi method — iterative anonymous expert feedback — to generate improvement or solution proposals for a given theme or challenge. |

### Session Management

| Command | Language | Description |
|---------|----------|-------------|
| `/worklog` | English | End-of-session sign-off: update `.backlog/` files and write local worklog. |

## Installation

Copy or symlink command files into your Claude Code commands folder:

```bash
# Global (all projects)
cp *.md ~/.claude/commands/

# Or symlink individual commands
ln -s /path/to/claude-commands/<command>.md ~/.claude/commands/
```

### Prerequisites

`/proofread-en` requires [vale](https://vale.sh/):

```bash
# macOS
brew install vale
```

`/proofread-jp` requires [MeCab](https://taku910.github.io/mecab/) with ipadic:

```bash
# macOS
brew install mecab mecab-ipadic
```

`/nanobanana` requires `GEMINI_API_KEY` environment variable. `/imagen` requires Google Cloud credentials (`gcloud auth print-access-token`).

## Usage Examples

```
/researcher-en Daniel Kahneman
/researcher-en Who created flow theory?
/researcher-jp ダニエル・カーネマン
/proofread-en The data shows that there is many problems with the approach.
/proofread-jp 今日はとても天気がいいである。まず最初に挨拶をします。
/proofread-mode /path/to/document.txt
/nanobanana a cat sitting on a rainbow
/imagen photorealistic mountain landscape at sunset
/delphi-method How can we reduce onboarding time for new engineers?
/worklog
```

## License

MIT
