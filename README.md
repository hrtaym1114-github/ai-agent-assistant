# AI Agent Assistant

> AIエージェントを業務に活用するためのオンボーディングキット

## What is this?

Claude Code（またはその他のAIコーディングエージェント）を使って、日常業務を効率化するための設定・テンプレート・ガイドを対話形式で構築できるツールキットです。

### こんな方に

- AIツールを導入したけど「何に使えばいいかわからない」
- ChatGPTは使っているが、もっと業務に組み込みたい
- セキュリティが心配でAI活用に踏み出せない
- チームにAI活用を広めたいが、説得材料がない

## Quick Start

### 前提条件

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) がインストール済み

### 取得方法

#### A. ZIP配布（社内配布向け・推奨）

1. ZIPファイルを受け取る（`ai-agent-assistant.zip`）
2. 任意のフォルダに展開

```bash
# 展開先の例
C:\work\ai-agent-assistant\
```

3. Claude Codeを起動

```bash
cd ai-agent-assistant
claude
```

#### B. Git Clone（GitHub経由）

```bash
git clone <リポジトリURL>
cd ai-agent-assistant
claude
```

### ガイドを実行

```
/ai
```

質問に答えるだけで、あなたに合った活用方法を提案＆構築します。

## Contents

```
ai-agent-assistant/
├── README.md                  # このファイル
├── CLAUDE.md                  # AIアシスタント指示書（自動読込）
├── .claude/
│   ├── commands/
│   │   └── ai.md                 # 対話ガイドスキル（/ai で実行）
│   └── settings.json          # セキュリティ設定（Level 2）
├── docs/
│   ├── getting-started.md     # セットアップガイド
│   ├── patterns.md            # 8つの活用パターン詳細
│   └── governance.md          # セキュリティ・ガバナンス
├── templates/
│   ├── claude-md-basic.md     # CLAUDE.md テンプレート
│   ├── email-reply.md         # メール返信テンプレート
│   ├── weekly-report.md       # 週次レポートテンプレート
│   └── daily-start-skill.md   # 朝ルーティン Skill テンプレート
└── sessions/                  # セッションレポート（自動生成）
```

## 8つの活用パターン

| パターン | 解決する課題 | 難易度 | 導入時間 |
|---------|-------------|--------|---------|
| **P1** プロジェクト指示書 | AIに毎回同じ説明をしている | ★ | 30分 |
| **P2** 常駐アシスタント | スキルを日常業務で伸ばしたい | ★ | 15分 |
| **P3** 情報トリアージ | 情報が散らかって見つからない | ★★ | 1-2時間 |
| **P4** パーソナライズ学習 | AIの文章が自分っぽくない | ★★★ | 2-3時間 |
| **P5** ガバナンス | AIの暴走やセキュリティが心配 | ★★ | 30分 |
| **P6** 知識資産記録 | AIとのやり取りが消えてしまう | ★★ | 1-2時間 |
| **P7** テンプレート駆動 | 毎回ゼロから文書を書いている | ★★ | 1時間 |
| **P8** ルーティン自動化 | 毎日同じ作業を手動でやっている | ★★ | 1-2時間 |

詳細: [docs/patterns.md](docs/patterns.md)

## 推奨導入順序

```
Week 1: P1（指示書）+ P5（ガバナンス）→ 基礎固め
Week 2: P7（テンプレート）+ P8（ルーティン）→ 日常組込み
Week 3-4: P3（トリアージ）+ P2（常駐）→ 高度化
Month 2+: P4（学習）+ P6（記録）→ パーソナライズ
```

## Security

デフォルトでLevel 2（標準）セキュリティが有効:

- ファイル削除をブロック
- Git破壊操作をブロック
- 外部サービスへの書き込みをブロック

詳細: [docs/governance.md](docs/governance.md)

## 社内配布について

### ZIP配布の手順

1. このリポジトリをZIPでダウンロード（またはGitHubのReleaseからZIPを取得）
2. 社内の共有フォルダやTeamsで配布
3. 各メンバーが展開してClaude Codeを起動するだけで利用開始

### 展開後の確認

```bash
cd ai-agent-assistant
claude
# Claude Code起動後に以下を実行
/ai
```

## 実績のある事例

- **住友商事**: M365 Copilot全社導入で年間12億円のコスト削減効果
- **ソフトバンク**: カスタムコマンド活用でソフトウェア開発工数34%削減
- **Anthropic法務チーム**: コード不要でClaude Code活用、レビュー時間2-4倍削減
- **学情**: 全社員にCopilot配布し定着率100%、新入社員も即戦力化
- **デンソー**: M365 Copilot導入でレポート作成時間を大幅短縮

## License

MIT

