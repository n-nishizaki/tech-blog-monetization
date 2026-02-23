---
name: blog-publish
description: ブログ記事をJekyll形式に変換してn-nishizaki.github.ioリポジトリへの公開準備を行う。/blog-review で60%基準をクリアしたファイルに対して使う。例: /blog-publish コンテンツ制作/drafts/article-02-points-v3.md
disable-model-invocation: true
---

# blog-publish: Jekyll形式変換 & 公開

対象ファイル: $ARGUMENTS

## 事前確認

- 対象ファイルが `/blog-review` でチェック済みであることを確認する
- ファイルを読み込んで内容を把握する

## 公開手順

### Step 1: 現在日付とブログリポジトリの状態確認

```bash
# 現在日付取得
date +%Y-%m-%d

# ブログリポジトリが利用可能か確認（session-start-hook でクローン済みかどうか）
BLOG_DIR="/home/user/n-nishizaki.github.io"
if [ -d "$BLOG_DIR/.git" ]; then
  echo "MODE=auto"
  ls "$BLOG_DIR/_posts/" | sort | tail -5
else
  echo "MODE=manual"
fi
```

**MODEによって以下の手順が変わる:**
- `auto`: ブログリポジトリに直接コピー → commit → push まで実行する
- `manual`: `コンテンツ制作/publish-ready/` にファイル作成 → オーナーへ手動手順を案内する

### Step 2: Jekyll front matter の更新

ドラフトの front matter を公開用に更新する。
`status: draft` を削除し、以下の形式に整える:

```yaml
---
title: [記事タイトル]
date: [YYYY-MM-DD] 10:00:00 +0900
categories: [カテゴリー1, カテゴリー2]
tags: [タグ1, タグ2, タグ3, タグ4]
description: "[120-160字のメタディスクリプション]"
---
```

**カテゴリー選択基準** (BLOG_CONCEPT.mdより):
- 資産形成, 投資 → 楽天証券・SBI証券アフィリエイト
- 転職, キャリア → 転職エージェントアフィリエイト
- プロジェクトマネジメント → ツール系アフィリエイト
- 子育て, 育児 → 知育玩具アフィリエイト
- システム思考, 自己理解 → 書籍・note

### Step 3: 公開用ファイル名の決定

命名規則: `YYYY-MM-DD-[英語スラッグ].md`

例:
- `2026-02-20-best-points-to-collect.md`
- `2026-02-20-offshore-vendor-selection.md`

### Step 4: ファイルの保存と公開

#### MODE=auto の場合（GITHUB_TOKEN設定済み・推奨）

以下を順番に実行する:

1. Jekyll形式のファイルを `/home/user/n-nishizaki.github.io/_posts/[YYYY-MM-DD-slug].md` に作成
2. `コンテンツ制作/publish-ready/` にも同じファイルを作成（バックアップ）
3. ブログリポジトリへ commit & push:

```bash
BLOG_DIR="/home/user/n-nishizaki.github.io"
cd "$BLOG_DIR"
git add _posts/[YYYY-MM-DD-slug].md
git commit --no-gpg-sign -m "feat: [記事タイトルの短縮版]を追加"
git push origin main
```

> **注**: このリポジトリはGitHubに直接pushするため、ローカルの署名設定が機能しない。
> `--no-gpg-sign` を使用すること（オーナー承認済み）。

#### MODE=manual の場合（GITHUB_TOKEN未設定）

対象のドラフトファイルをJekyll形式に変換して以下に保存:
`コンテンツ制作/publish-ready/[YYYY-MM-DD-slug].md`

### Step 5: 完了レポート出力

#### MODE=auto の完了レポート

```
## 公開完了 ✅

**公開ファイル**: /home/user/n-nishizaki.github.io/_posts/[ファイル名]
**ブログURL**: https://n-nishizaki.github.io/posts/[スラッグ]/
**文字数**: [XX]字

**公開後の確認**（2-3分後）:
1. GitHub Actions のビルド完了を確認
2. https://n-nishizaki.github.io/posts/[スラッグ]/ にアクセスして表示を確認
```

#### MODE=manual の完了レポート

```
## 公開準備完了

**作成ファイル**: コンテンツ制作/publish-ready/[ファイル名]
**ブログURL（公開後）**: https://n-nishizaki.github.io/posts/[スラッグ]/
**文字数**: [XX]字

## オーナーの作業（手動）

以下をオーナーが実行してください:

```bash
cp ~/tech-blog-monetization/コンテンツ制作/publish-ready/[ファイル名] \
   ~/my-project/n-nishizaki.github.io/_posts/
cd ~/my-project/n-nishizaki.github.io
git add _posts/[ファイル名]
git commit -m "feat: [記事タイトルの短縮版]を追加"
git push origin main
```

💡 GITHUB_TOKEN を Claude Code 設定に追加すると次回から自動化されます。
```

## ルール

- ドラフトファイル（コンテンツ制作/drafts/）は削除しない
- ブログリポジトリの既存ファイルは変更しない（_posts/ への追加のみ）
- MODE=auto のときは git push まで実行してよい
- MODE=manual のときは git 操作はオーナーが手動で行う
