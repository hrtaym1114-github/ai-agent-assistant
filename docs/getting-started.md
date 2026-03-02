# Getting Started — セットアップガイド

## 前提条件

- **Claude Code** がインストール済み
  - インストール方法: https://docs.anthropic.com/en/docs/claude-code
  - `npm install -g @anthropic-ai/claude-code`
- ターミナル（コマンドプロンプト/PowerShell/Terminal）が使える

## セットアップ手順

### 1. キットの取得

#### 方法A: ZIPファイルから（推奨・Git不要）

1. 配布された `ai-agent-assistant.zip` を受け取る
2. 任意のフォルダに展開する

```bash
# 展開先の例（Windows）
C:\work\ai-agent-assistant\

# 展開先の例（Mac/Linux）
~/work/ai-agent-assistant/
```

#### 方法B: Git Cloneから

```bash
git clone <リポジトリURL>
cd ai-agent-assistant
```

### 2. Claude Codeの起動

```bash
cd ai-agent-assistant
claude
```

起動すると、`CLAUDE.md` が自動的に読み込まれ、AIアシスタントが利用可能になります。

### 3. ガイドの実行

```
/ai
```

対話ガイドが始まります。質問に答えていくだけで、あなたの業務に合った活用方法が提案されます。

## 3つの使い方

### A. 初めての方（ガイド型）

```
/ai
```

→ 「ガイド型」を選択 → 3つの質問に答えるだけ

### B. 自分の課題がわかっている方（自由記述）

```
/ai
```

→ 「自由記述」を選択 → 困りごとを自由に記述

### C. 構築したいものが決まっている方（クイック構築）

```
/ai --build P1   # CLAUDE.mdを作りたい
/ai --build P5   # セキュリティ設定を作りたい
/ai --build P7   # テンプレートを作りたい
/ai --build P8   # ルーティン自動化を作りたい
```

## このキットの構成

```
ai-agent-assistant/
├── CLAUDE.md              ← AIが自動読込（触らなくてOK）
├── .claude/
│   ├── commands/          ← 対話ガイド（触らなくてOK）
│   └── settings.json      ← セキュリティ設定（カスタマイズ可）
├── docs/                  ← ドキュメント
├── templates/             ← テンプレート集
└── sessions/              ← セッションレポート（自動生成）
```

## よくある質問

### Q: Claude Code以外のツールでも使えますか？

A: このキットはClaude Code用に設計されていますが、パターンの考え方やテンプレートは他のAIツール（Copilot、ChatGPT等）でも応用できます。`docs/patterns.md` を参照してください。

### Q: セキュリティは大丈夫ですか？

A: デフォルトでLevel 2（標準）のセキュリティ設定が有効です。ファイル削除、Git破壊操作、外部サービスへの書き込みがブロックされます。詳細は `docs/governance.md` を参照。

### Q: チーム全体に展開するには？

A: ZIPファイルをチームの共有フォルダやTeamsで配布し、各メンバーが展開して `/ai` を実行するだけです。セッションレポートが自動生成されるので、導入状況の把握も可能です。

### Q: 自分のプロジェクトに適用するには？

A: `/ai` でMVPを構築すると、CLAUDE.mdやsettings.json等のファイルが生成されます。これらを自分のプロジェクトフォルダにコピーしてください。

### Q: Gitを使えなくても大丈夫ですか？

A: はい。ZIPファイルを展開するだけで使えます。Gitの知識は不要です。

## 次のステップ

1. `/ai` を実行して最初のパターンを構築
2. 1週間使ってみて効果を実感
3. 2つ目のパターンを追加（`/ai` を再実行）
4. チームメンバーにも紹介（セッションレポートを共有）
