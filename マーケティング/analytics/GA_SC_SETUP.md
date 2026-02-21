# Google Analytics & Search Console セットアップガイド

---
**作成日**: 2026-02-17
**対象ブログ**: https://n-nishizaki.github.io/
**ステータス**: 実行準備中
---

## 概要

このドキュメントは、「システム思考実践ノート」ブログに Google Analytics (GA4) と Google Search Console (GSC) を導入するための手順書です。

### 目的
- ブログへのアクセス状況を把握
- SEO パフォーマンスを追跡
- ユーザー行動分析から改善ポイントを特定
- マネタイズ施策の効果測定

---

## 前提条件

### 必要なもの
- Google アカウント（Gmail等で登録済み）
- ブログの所有権確認
- 既存の記事（最低1記事以上）

### 確認事項
- ブログURL: `https://n-nishizaki.github.io/`
- ブログタイプ: Jekyll + GitHub Pages
- 現在の記事数: 1記事

---

## セットアップ手順

### 1. Google Analytics 4 (GA4) の設定

#### 1-1. Google Analytics にアクセス
1. [Google Analytics](https://analytics.google.com/) にアクセス
2. Googleアカウントでログイン

#### 1-2. プロパティの作成
1. **管理** → **アカウント一覧** へ
2. **新しいアカウントを作成** をクリック
3. アカウント設定:
   - **アカウント名**: `システム思考実践ノート`
   - **データ共有設定**: すべてチェック（推奨）

#### 1-3. プロパティの設定
1. **プロパティ名**: `システム思考実践ノート ブログ`
2. **レポートのタイムゾーン**: `日本`
3. **通貨**: `JPY（日本円）`

#### 1-4. ウェブストリームの作成
1. **業種カテゴリ**: `メディア・発行`
2. **ウェブサイトURL**: `https://n-nishizaki.github.io`
3. **ストリーム名**: `Website`

#### 1-5. トラッキングコードの取得
1. **ストリーム設定** から **測定ID** をコピー
   - 形式: `G-XXXXXXXXXX`
2. 後ほど Jekyll に設定

---

### 2. Jekyll への GA4 統合

#### 2-1. _config.yml の編集
Jekyll ブログの `_config.yml` に以下を追加:

```yaml
# Google Analytics
google_analytics: "G-XXXXXXXXXX"  # 上記の測定IDに置換
```

#### 2-2. レイアウトファイルの確認
デフォルトテンプレート（`_layouts/default.html`）に以下を確認:

```html
{% if site.google_analytics %}
  <!-- Google Analytics -->
  <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.google_analytics }}"></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', '{{ site.google_analytics }}');
  </script>
{% endif %}
```

#### 2-3. デプロイ
```bash
git add _config.yml
git commit -m "feat: GA4トラッキングコードを追加"
git push origin main
```

#### 2-4. 確認待ち
- デプロイ後、GA管理画面で「リアルタイム」レポートを確認
- ブログにアクセスしてデータ送信を確認（24時間で完全にセットアップ完了）

---

### 3. Google Search Console (GSC) の設定

#### 3-1. Google Search Console にアクセス
1. [Google Search Console](https://search.google.com/search-console) にアクセス
2. Googleアカウントでログイン

#### 3-2. サイト登録
1. **プロパティを追加** をクリック
2. **URL接頭辞** を選択
3. URL: `https://n-nishizaki.github.io`

#### 3-3. サイト所有権の確認
いずれかの方法で確認（**推奨: DNS TXT レコード**）:

**方法1: DNS TXT レコード（推奨）**
- GitHub Pages の場合、カスタムドメイン設定が必要
- 現在は GitHub 提供ドメインのため、HTMLファイルで代替

**方法2: HTMLファイル（推奨: GitHub Pages の場合）**
1. GSC から HTML ファイルをダウンロード
2. ブログの `root` フォルダに配置
3. GitHub にコミット・プッシュ
4. GSC で確認ボタンを押す

#### 3-4. サイトマップの送信
1. **サイトマップ** セクションへ
2. URL 入力欄に: `https://n-nishizaki.github.io/sitemap.xml`
3. **送信** をクリック

#### 3-5. robots.txt の確認
Jekyll ブログのルートに `robots.txt` があるか確認:

```
User-agent: *
Allow: /
Sitemap: https://n-nishizaki.github.io/sitemap.xml
```

---

## セットアップチェックリスト

### GA4 セットアップ
- [ ] Google Analytics アカウント作成完了
- [ ] プロパティ作成完了
- [ ] ウェブストリーム作成完了
- [ ] 測定ID取得完了
- [ ] `_config.yml` に測定ID追加
- [ ] デプロイ確認
- [ ] リアルタイムレポートでアクセス確認

### GSC セットアップ
- [ ] Google Search Console にプロパティ追加
- [ ] サイト所有権確認完了
- [ ] サイトマップ送信完了
- [ ] robots.txt 確認完了

### 確認作業
- [ ] GA管理画面で設定確認
- [ ] GSC ダッシュボードでサイト表示確認
- [ ] 24時間経過後、データレポートで収集確認

---

## 運用フロー

### 初期運用（セットアップ後）
1. **GA データ確認** （3-7日後）
   - ユーザー数、セッション数を確認
   - 主な流入元（Direct, Organic Search等）を記録

2. **GSC データ確認** （1週間後）
   - インデックス登録状況
   - 検索クエリ（どのキーワードで検出されたか）
   - 検索パフォーマンス（CTR, 表示回数）

3. **初期分析** （2週間後）
   - 初回記事のアクセス状況を分析
   - 改善ポイントを特定

### 定期運用
- **週次**: GA で新規ユーザーと人気記事確認
- **週次**: GSC で検索パフォーマンス確認
- **月次**: 詳細な分析レポート作成

---

## トラブルシューティング

### GA4 データが表示されない
- [ ] 測定IDが正しく _config.yml に設定されているか確認
- [ ] デプロイ後、24時間待機
- [ ] ブラウザキャッシュをクリアして再度アクセス
- [ ] リアルタイムレポートで即時確認

### GSC でサイト未確認
- [ ] HTMLファイルを正しいフォルダに配置したか確認
- [ ] robots.txt があるか確認
- [ ] サイトマップが存在するか確認（`/sitemap.xml`）

### 検索クエリが表示されない
- インデックス登録待機中（通常1-2週間）
- サイトマップが正しく送信されているか確認

---

## 参照リンク

### Google Analytics
- [GA4 ヘルプ](https://support.google.com/analytics)
- [GitHub Pages + GA4 統合ガイド](https://docs.github.com/)

### Google Search Console
- [GSC ヘルプ](https://support.google.com/webmasters)
- [検索パフォーマンスレポート](https://support.google.com/webmasters/answer/7042828)

### Jekyll
- [Jekyll SEO タグ](https://github.com/jekyll/jekyll-seo-tag)
- [Jekyll プラグイン](https://jekyllrb.com/docs/plugins/)

---

## 次のステップ

セットアップ後、以下の作業に進む：

1. **Google AdSense 申請準備**
   - GA・GSC 連携確認
   - ブログ品質チェック
   - ポリシー遵守確認

2. **アフィリエイトプログラム登録**
   - 楽天
   - SBI証券
   - その他金融商品

3. **SEO 最適化**
   - キーワード分析
   - メタディスクリプション最適化
   - 内部リンク構造改善

---

**最終確認日**: 2026-02-17
**セットアップ責任者**: Claude
**承認者**: オーナー
