---
name: blog-publish
description: ブログ記事をJekyll形式に変換してn-nishizaki.github.ioリポジトリへの公開準備を行う。/blog-review で60%基準をクリアしたファイルに対して使う。例: /blog-publish コンテンツ制作/drafts/article-02-points-v3.md
disable-model-invocation: true
---

# blog-publish: Jekyll形式変換 & 公開準備

対象ファイル: $ARGUMENTS

## 事前確認

- 対象ファイルが `/blog-review` でチェック済みであることを確認する
- ファイルを読み込んで内容を把握する

## 公開手順

### Step 1: 現在日付と記事番号の確認

```bash
# 現在日付取得
date +%Y-%m-%d

# ブログリポジトリの既存投稿を確認
ls /Users/norio/my-project/n-nishizaki.github.io/_posts/ | sort
```

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

### Step 4: 公開用ファイルをブログリポジトリに作成

対象のドラフトファイルをJekyll形式に変換して以下に保存:
`/Users/norio/my-project/n-nishizaki.github.io/_posts/[YYYY-MM-DD-slug].md`

**注意**: ファイルの作成のみ行う。git操作（add/commit/push）は行わない。

### Step 5: ビルドプレビュー確認（オプション）

```bash
# ブログリポジトリのディレクトリを確認
ls /Users/norio/my-project/n-nishizaki.github.io/
```

ローカルビルドが設定されている場合は確認手順を案内する。

### Step 6: 完了レポート出力

```
## 公開準備完了

**作成ファイル**: /Users/norio/my-project/n-nishizaki.github.io/_posts/[ファイル名]
**ブログURL**: https://n-nishizaki.github.io/posts/[スラッグ]/
**文字数**: [XX]字

## オーナーの作業（手動）

以下をオーナーが実行してください:

```bash
cd /Users/norio/my-project/n-nishizaki.github.io
git add _posts/[ファイル名]
git commit -m "feat: [記事タイトルの短縮版]を追加"
git push origin main
```

**公開後の確認**:
1. GitHub Actions のビルド完了を確認（2-3分）
2. https://n-nishizaki.github.io/posts/[スラッグ]/ にアクセスして表示を確認
3. メタディスクリプションが正しく表示されているか確認

## 公開後タスク（コンテンツ制作CLAUDE.mdに記録）

- [ ] 完成済み記事一覧に追加
- [ ] 次の記事の計画を開始
```

## 禁止事項

- git add / git commit / git push は実行しない（オーナーが手動で行う）
- ブログリポジトリの既存ファイルを変更しない
- ドラフトファイル（コンテンツ制作/drafts/）を削除しない
