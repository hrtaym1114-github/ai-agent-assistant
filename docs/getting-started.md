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

## 4つの使い方

### A. 初めての方（ガイド型）

```
/ai
```

→ 「ガイド型」を選択 → 3つの質問に答えるだけ

### B. まず実力を見たい方（デモ）

```
/ai
```

→ 「Claude Codeの実力を見せて」を選択 → ファイル分析・文書生成・データ処理をライブデモ

### C. 自分の課題がわかっている方（自由記述）

```
/ai
```

→ 「自由記述」を選択 → 困りごとを自由に記述

### D. 構築したいものが決まっている方（クイック構築）

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

A: まず自分で `/ai` を実行して成功体験を得てください。次に `/ai --share` で共有パックを作成し、チームの共有フォルダやTeamsで配布します。各メンバーが展開して `/ai` を実行するだけで同じ環境が手に入ります。

### Q: 自分のプロジェクトに適用するには？

A: `/ai` でMVPを構築すると、CLAUDE.mdやsettings.json等のファイルが生成されます。これらを自分のプロジェクトフォルダにコピーしてください。

### Q: Gitを使えなくても大丈夫ですか？

A: はい。ZIPファイルを展開するだけで使えます。Gitの知識は不要です。

## 次のステップ

1. `/ai` を実行して最初のパターンを構築
2. 構築したワークフローをカスタムコマンドにする（セッション内で案内されます）
3. 1週間使ってみて効果を実感
4. `/ai --share` で共有パックを作成し、チームメンバーに紹介
5. 2つ目のパターンを追加（`/ai` を再実行）
