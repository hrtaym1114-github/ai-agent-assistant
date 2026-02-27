# セキュリティ・ガバナンスガイド

AIエージェントを安全に業務活用するための3層防御モデルと設定ガイド。

---

## 3層防御モデル

```
┌─────────────────────────────────────────────────────┐
│  Layer 3: 確認（Confirm）                            │
│  高リスク操作 → 人間の承認を要求                      │
│  ┌─────────────────────────────────────────────────┐ │
│  │  Layer 2: 制限（Scope）                          │ │
│  │  作業範囲・ファイル範囲を限定                      │ │
│  │  ┌─────────────────────────────────────────────┐ │ │
│  │  │  Layer 1: 禁止（Deny）                       │ │ │
│  │  │  絶対にやらせない操作を定義                    │ │ │
│  │  └─────────────────────────────────────────────┘ │ │
│  └─────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────┘
```

---

## Layer 1: 禁止（Deny）— settings.json

### Level 1: 最小限（個人利用におすすめ）

```json
{
  "permissions": {
    "defaultMode": "default",
    "deny": [
      "Bash(rm *)", "Bash(rm -r*)", "Bash(rm -f*)", "Bash(rm -rf*)",
      "Bash(rmdir *)", "Bash(del *)", "Bash(rd *)",
      "Bash(unlink *)", "Bash(Remove-Item*)",
      "Bash(*| rm *)", "Bash(*&& rm *)", "Bash(*; rm *)"
    ]
  }
}
```

**ブロック対象**: ファイル/フォルダ削除のみ

### Level 2: 標準（業務利用推奨）

```json
{
  "permissions": {
    "defaultMode": "default",
    "deny": [
      "Bash(rm *)", "Bash(rm -r*)", "Bash(rm -f*)", "Bash(rm -rf*)",
      "Bash(rmdir *)", "Bash(del *)", "Bash(del /s*)",
      "Bash(rd *)", "Bash(rd /s*)",
      "Bash(unlink *)", "Bash(Remove-Item*)",
      "Bash(*| rm *)", "Bash(*&& rm *)", "Bash(*; rm *)",
      "Bash(git push --force*)", "Bash(git push -f*)",
      "Bash(git reset --hard*)", "Bash(git clean -f*)",
      "Bash(git checkout -- *)", "Bash(git branch -D*)",
      "Bash(curl -X POST*)", "Bash(curl -X PUT*)", "Bash(curl -X DELETE*)",
      "Bash(wget --post*)"
    ]
  }
}
```

**追加ブロック**: Git破壊操作 + 外部へのPOST/PUT/DELETE送信

### Level 3: 厳格（機密環境向け）

```json
{
  "permissions": {
    "defaultMode": "plan",
    "deny": [
      "Bash(rm *)", "Bash(rm -r*)", "Bash(rm -f*)", "Bash(rm -rf*)",
      "Bash(rmdir *)", "Bash(del *)", "Bash(del /s*)",
      "Bash(rd *)", "Bash(rd /s*)",
      "Bash(unlink *)", "Bash(Remove-Item*)",
      "Bash(*| rm *)", "Bash(*&& rm *)", "Bash(*; rm *)",
      "Bash(git push --force*)", "Bash(git push -f*)",
      "Bash(git reset --hard*)", "Bash(git clean -f*)",
      "Bash(git checkout -- *)", "Bash(git branch -D*)",
      "Bash(curl *)", "Bash(wget *)", "Bash(Invoke-WebRequest*)",
      "Bash(ssh *)", "Bash(scp *)", "Bash(sftp *)",
      "Bash(pip install*)", "Bash(npm install*)", "Bash(apt install*)",
      "Bash(brew install*)", "Bash(choco install*)",
      "Bash(export *)", "Bash(set *=*)",
      "Bash(chmod *)", "Bash(chown *)",
      "Bash(kill *)", "Bash(taskkill *)"
    ]
  }
}
```

**追加ブロック**: 全ネットワーク通信 + パッケージインストール + 環境変数変更 + プロセス操作

---

## Layer 2: 制限（Scope）— CLAUDE.mdで設定

CLAUDE.mdに以下のようなセクションを追加して作業範囲を制限:

```markdown
## 作業範囲の制限

1. **ディレクトリ制限**: このプロジェクトフォルダ内でのみ作業すること
   - 外部ディレクトリへのファイル操作禁止

2. **禁止操作**:
   - ファイルの削除 ❌
   - フォルダの削除 ❌

3. **許可される操作**:
   - ファイルの読み取り ✅
   - 新規ファイルの作成 ✅
   - 既存ファイルの編集 ✅
   - ファイル検索 ✅
```

### 機密情報の取り扱い

CLAUDE.mdに追加するマスキング指示:

```markdown
## 機密情報の取り扱い

以下の情報が含まれるファイルを処理する際は、自動的にマスキングすること:
- 個人名 → [氏名]
- メールアドレス → [email]
- 電話番号 → [phone]
- 社員番号 → [emp_id]
- 顧客名/顧客番号 → [customer]
- 金額（契約額等） → [amount]
```

---

## Layer 3: 確認（Confirm）— defaultMode

| モード | 動作 | 推奨対象 |
|--------|------|---------|
| `plan` | 全操作に事前承認を要求 | 初心者、機密環境 |
| `default` | 高リスク操作のみ確認 | 標準的な業務利用 |
| `bypassPermissions` | 確認なし（deny以外は全自動） | 上級者、信頼環境 |

**推奨導入パス**:
```
初回: plan モード（全操作を確認 → AIの動きを学ぶ）
  ↓ 1-2週間後
標準: default モード（高リスクのみ確認）
  ↓ 十分な経験後
上級: bypassPermissions（deny設定で安全確保しつつ自動化）
```

---

## 環境別推奨設定

| 環境 | deny Level | scope | mode | ログ |
|------|-----------|-------|------|------|
| 個人学習 | Level 1 | なし | plan → default | 任意 |
| 個人業務 | Level 1 | フォルダ制限 | default | 推奨 |
| チーム開発 | Level 2 | フォルダ+所有権 | default | 必須 |
| 社内業務（一般） | Level 2 | フォルダ+ファイルタイプ | default | 必須 |
| 社内業務（機密） | Level 3 | 厳格制限 | plan | 必須 |

---

## Quick Start: 3分でガバナンス設定

### Step 1: settings.json確認（1分）

このキットに含まれる `.claude/settings.json` はLevel 2（標準）設定済み。
そのまま使えます。Level変更が必要な場合は上記テンプレートをコピー。

### Step 2: CLAUDE.mdにスコープ追記（1分）

```markdown
## 作業範囲
- このプロジェクトフォルダ内でのみ作業してください
- ファイルの削除は禁止です
- 外部サービスへの情報送信前は必ず確認してください
```

### Step 3: 動作確認（1分）

AIに「テスト: rm test.txt を実行して」と依頼 → ブロックされることを確認

---

## データ境界の定義

| 区分 | AIに渡せるか | 対策 |
|------|------------|------|
| **公開情報** | ✅ OK | なし |
| **社内一般** | ✅ OK（社内環境） | 外部送信は要確認 |
| **部門限定** | ⚠️ 条件付き | スコープ制限+監査ログ |
| **機密情報** | ❌ 原則NG | マスキング必須 |
| **極秘情報** | ❌ 絶対NG | AI利用自体を禁止 |
