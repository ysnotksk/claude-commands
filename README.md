# Claude Code Commands

Custom [slash commands](https://docs.anthropic.com/en/docs/claude-code/tutorials/slash-commands) for [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview).

## Available Commands

| Command | Language | Description |
|---------|----------|-------------|
| `/researcher-en` | English | Generate comprehensive researcher profiles with full publication lists, methodology details, and footnoted sources. Supports forward lookup (name → profile) and reverse lookup (concept → researchers). |
| `/researcher-jp` | Japanese | 研究者のプロフィール・全研究実績を体系的にまとめたドキュメントを生成。正引き（研究者名→プロフィール）と逆引き（概念名→研究者）に対応。 |
| `/proofread-jp` | Japanese | MeCab 形態素解析を使った日本語校正。文体混在・重複表現・助詞誤用・長文等を検出。 |

## Installation

Copy or symlink command files into your Claude Code commands folder:

```bash
# Global (all projects)
cp *.md ~/.claude/commands/

# Or symlink
ln -s /path/to/claude-commands/researcher-en.md ~/.claude/commands/
ln -s /path/to/claude-commands/researcher-jp.md ~/.claude/commands/
ln -s /path/to/claude-commands/proofread-jp.md ~/.claude/commands/
```

### Prerequisites

`/proofread-jp` requires [MeCab](https://taku910.github.io/mecab/) with ipadic:

```bash
# macOS
brew install mecab mecab-ipadic
```

## Usage Examples

```
/researcher-en Daniel Kahneman
/researcher-en Who created flow theory?
/researcher-jp ダニエル・カーネマン
/researcher-jp フロー理論を作った人は？
/proofread-jp 今日はとても天気がいいである。まず最初に挨拶をします。
/proofread-jp /path/to/document.txt
```

## License

MIT
