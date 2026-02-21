# Google Analytics & Search Console - 実作業手順

---
**作成日**: 2026-02-17
**対象ブログ**: https://n-nishizaki.github.io/
**ステータス**: 作業中
---

## 事前確認完了事項

### ブログ現状
- ✅ Jekyll (Chirpy テーマ) で構築済み
- ✅ _config.yml 存在確認完了
- ✅ GA4 設定欄確認（61-62行目、現在空）
- ❌ sitemap.xml 未設定
- ❌ robots.txt 未設定

---

## セットアップ手順（実行順）

### Phase 1: sitemap.xml と robots.txt の追加

#### Step 1-1: jekyll-sitemap プラグイン追加

**ファイル**: `/Users/norio/my-project/n-nishizaki.github.io/Gemfile`

以下を追加:
```ruby
gem 'jekyll-sitemap'
```

**実行コマンド**:
```bash
cd /Users/norio/my-project/n-nishizaki.github.io
bundle install
```

#### Step 1-2: _config.yml にプラグイン設定追加

**ファイル**: `/Users/norio/my-project/n-nishizaki.github.io/_config.yml`

`plugins:` セクションに以下を追加（既存のpluginsセクションがあれば、そこに追加）:
```yaml
plugins:
  - jekyll-sitemap
```

もし `plugins:` セクションがなければ、以下を追加:
```yaml
# Plugins
plugins:
  - jekyll-sitemap
```

#### Step 1-3: robots.txt を作成

**ファイル**: `/Users/norio/my-project/n-nishizaki.github.io/robots.txt`

以下の内容で新規作成:
```
User-agent: *
Allow: /

Sitemap: https://n-nishizaki.github.io/sitemap.xml
```

#### Step 1-4: ビルドして確認

```bash
cd /Users/norio/my-project/n-nishizaki.github.io
bundle exec jekyll build
ls _site/ | grep -E "sitemap|robots"
```

期待される出力:
```
robots.txt
sitemap.xml
```

#### Step 1-5: Git コミット

```bash
cd /Users/norio/my-project/n-nishizaki.github.io
git add Gemfile Gemfile.lock _config.yml robots.txt
git commit -m "feat: sitemap.xml と robots.txt を追加"
git push origin main
```

---

### Phase 2: Google Analytics 4 (GA4) セットアップ

#### Step 2-1: Google Analytics アカウント作成

**注意**: この作業は**オーナー自身**が実行してください。

1. [Google Analytics](https://analytics.google.com/) にアクセス
2. Googleアカウントでログイン
3. **管理** → **アカウントを作成**
4. アカウント設定:
   - **アカウント名**: `システム思考実践ノート`
   - **データ共有設定**: すべてチェック（推奨）

#### Step 2-2: プロパティ作成

1. **プロパティ名**: `システム思考実践ノート ブログ`
2. **レポートのタイムゾーン**: `日本`
3. **通貨**: `日本円 (¥)`

#### Step 2-3: ウェブストリーム作成

1. **業種カテゴリ**: `メディア・発行`
2. **ウェブサイトURL**: `https://n-nishizaki.github.io`
3. **ストリーム名**: `Website`

#### Step 2-4: 測定ID取得

1. **ストリーム設定** から **測定ID** をコピー
   - 形式: `G-XXXXXXXXXX`
2. この測定IDを次のステップで使用

---

### Phase 3: Jekyll への GA4 統合

#### Step 3-1: _config.yml に測定ID追加

**ファイル**: `/Users/norio/my-project/n-nishizaki.github.io/_config.yml`

61-62行目の以下の部分:
```yaml
analytics:
  google:
    id: # fill in your Google Analytics ID
```

を、以下のように変更（測定IDを実際の値に置換）:
```yaml
analytics:
  google:
    id: G-XXXXXXXXXX  # 実際の測定IDに置換
```

#### Step 3-2: Git コミット & プッシュ

```bash
cd /Users/norio/my-project/n-nishizaki.github.io
git add _config.yml
git commit -m "feat: Google Analytics 4 測定IDを追加"
git push origin main
```

#### Step 3-3: デプロイ確認

GitHub Actions が自動でデプロイを開始します。
- **確認URL**: https://github.com/n-nishizaki/n-nishizaki.github.io/actions

デプロイ完了後（通常1-3分）、以下で確認:
1. ブログにアクセス: https://n-nishizaki.github.io/
2. ブラウザの開発者ツール（F12） → ネットワークタブ
3. `gtag/js?id=G-XXXXXXXXXX` のリクエストを確認

#### Step 3-4: GA管理画面でリアルタイム確認

1. Google Analytics 管理画面へ
2. **レポート** → **リアルタイム**
3. ブログにアクセスして、リアルタイムユーザー数が増加することを確認

---

### Phase 4: Google Search Console (GSC) セットアップ

#### Step 4-1: Google Search Console にプロパティ追加

**注意**: この作業は**オーナー自身**が実行してください。

1. [Google Search Console](https://search.google.com/search-console) にアクセス
2. Googleアカウントでログイン
3. **プロパティを追加** をクリック
4. **URL接頭辞** を選択
5. URL: `https://n-nishizaki.github.io` を入力
6. **続行** をクリック

#### Step 4-2: サイト所有権の確認

**推奨方法: HTMLファイル**（GitHub Pages の場合）

1. GSC から HTML ファイルをダウンロード
   - ファイル名: `google1234567890abcdef.html`（実際のファイル名は異なる）
2. ブログのルートフォルダに配置:
   ```bash
   # ダウンロードしたファイルを移動
   mv ~/Downloads/google1234567890abcdef.html /Users/norio/my-project/n-nishizaki.github.io/
   ```
3. Git コミット & プッシュ:
   ```bash
   cd /Users/norio/my-project/n-nishizaki.github.io
   git add google*.html
   git commit -m "feat: Google Search Console 所有権確認ファイルを追加"
   git push origin main
   ```
4. デプロイ完了後、GSC で **確認** ボタンをクリック

**代替方法: Google Analytics を使用**（GA4設定済みの場合）

1. GSC 所有権確認画面で **別の方法** を選択
2. **Google Analytics** を選択
3. 自動で確認完了（同じGoogleアカウントでGA4とGSCを使用している場合）

#### Step 4-3: サイトマップ送信

1. GSC ダッシュボード → **サイトマップ** セクションへ
2. URL 入力欄に: `sitemap.xml` を入力
3. **送信** をクリック
4. ステータスが「成功しました」になるのを確認

---

### Phase 5: 動作確認

#### 確認1: sitemap.xml と robots.txt

ブラウザで以下にアクセス:
- https://n-nishizaki.github.io/sitemap.xml
- https://n-nishizaki.github.io/robots.txt

両方が正しく表示されることを確認。

#### 確認2: Google Analytics

1. ブログにアクセス
2. GA管理画面で **リアルタイム** レポート確認
3. ユーザー数が 1 になることを確認

#### 確認3: Google Search Console

1. GSC ダッシュボードにブログが表示されることを確認
2. **サイトマップ** セクションで「成功しました」ステータス確認
3. 24-48時間後、**ページ** セクションでインデックス状況確認

---

## チェックリスト

### Phase 1: sitemap & robots.txt
- [ ] Gemfile に jekyll-sitemap 追加
- [ ] bundle install 実行
- [ ] _config.yml に plugins 設定追加
- [ ] robots.txt 作成
- [ ] ビルド確認（_site/ に sitemap.xml と robots.txt 生成）
- [ ] Git コミット & プッシュ

### Phase 2: Google Analytics
- [ ] GA アカウント作成完了
- [ ] プロパティ作成完了
- [ ] ウェブストリーム作成完了
- [ ] 測定ID取得完了（G-XXXXXXXXXX）

### Phase 3: Jekyll への GA4 統合
- [ ] _config.yml に測定ID追加
- [ ] Git コミット & プッシュ
- [ ] デプロイ完了確認
- [ ] ブラウザ開発者ツールで gtag リクエスト確認
- [ ] GA リアルタイムレポートで動作確認

### Phase 4: Google Search Console
- [ ] GSC にプロパティ追加
- [ ] サイト所有権確認完了
- [ ] サイトマップ送信完了

### Phase 5: 動作確認
- [ ] sitemap.xml ブラウザアクセス確認
- [ ] robots.txt ブラウザアクセス確認
- [ ] GA リアルタイムレポート確認
- [ ] GSC ダッシュボード確認

---

## 次のステップ

セットアップ完了後、以下を実施:

### 1週間後
- GA データ確認（ユーザー数、セッション数、流入元）
- GSC インデックス状況確認

### 2週間後
- 初回記事のアクセス解析
- 検索クエリ分析
- 改善ポイント特定

### 1ヶ月後
- 月次レポート作成
- Google AdSense 申請準備検討
- アフィリエイトプログラム登録検討

---

**最終更新**: 2026-02-17
**作成者**: Claude
**承認者**: オーナー
