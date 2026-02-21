# Google Analytics 4 - 動作確認ガイド

---
**作成日**: 2026-02-17
**測定ID**: G-X1XJMK7DX6
**ステータス**: デプロイ中 → 確認待ち
---

## 設定完了しました！

Google Analytics 4 の測定ID（`G-X1XJMK7DX6`）をブログに設定し、GitHub にプッシュしました。

現在、GitHub Actions でデプロイが進行中です。

---

## Step 1: デプロイ完了を確認

### 1-1. GitHub Actions にアクセス

以下のURLをブラウザで開いてください：

👉 **https://github.com/n-nishizaki/n-nishizaki.github.io/actions**

### 1-2. デプロイ状況を確認

最新のワークフロー（一番上）を確認してください：

**進行中の場合**:
```
🟡 feat: Google Analytics 4 測定IDを追加
   進行中...
```

**完了した場合**:
```
✅ feat: Google Analytics 4 測定IDを追加
   完了（1分前）
```

**通常、1-3分で完了します。**

---

## Step 2: ブラウザの開発者ツールで確認

デプロイ完了後、以下の手順で Google Analytics が正しく動作しているか確認します。

### 2-1. ブログにアクセス

ブラウザで以下を開いてください：
👉 **https://n-nishizaki.github.io/**

### 2-2. 開発者ツールを開く

**Windows / Linux**:
- `F12` キーを押す
- または `Ctrl + Shift + I`

**Mac**:
- `Cmd + Option + I`

### 2-3. ネットワークタブを選択

開発者ツールの上部メニューから **「Network」**（ネットワーク）タブをクリック

### 2-4. ページをリロード

- `F5` キーを押してページをリロード
- または `Ctrl + R`（Mac: `Cmd + R`）

### 2-5. gtag リクエストを確認

1. フィルタ欄に「**gtag**」と入力
2. 以下のようなリクエストがあればOK:

```
gtag/js?id=G-X1XJMK7DX6    200    script
collect?v=2&...            204    xhr
```

**✅ この表示があれば、Google Analytics は正常に動作しています！**

---

## Step 3: Google Analytics でリアルタイム確認

### 3-1. Google Analytics 管理画面にアクセス

👉 **https://analytics.google.com/**

### 3-2. プロパティを選択

左上のプロパティ選択ドロップダウンから：
```
システム思考実践ノート ブログ
```
を選択

### 3-3. リアルタイムレポートを開く

左メニューから：
**「レポート」** → **「リアルタイム」** をクリック

### 3-4. リアルタイムユーザーを確認

ブログにアクセスした状態で、以下が表示されればOK:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
リアルタイム ユーザー
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
       1
過去 30 分間
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**表示される情報**:
- 現在のアクティブユーザー数
- 閲覧されているページ
- ユーザーの所在地（国、都市）
- デバイス（PC、スマホ、タブレット）
- 流入元（Direct, Organic Search など）

**✅ ユーザー数が表示されれば、データ収集が開始されています！**

---

## Step 4: 詳細レポートの確認（24時間後）

リアルタイムレポートは即座に表示されますが、詳細なレポートは **24時間後** から利用可能になります。

### 4-1. 確認できるレポート（24時間後）

#### ユーザー属性
**「レポート」** → **「ユーザー」** → **「ユーザー属性」**
- 新規ユーザー数
- リピーター数
- セッション数
- 平均セッション時間

#### トラフィック獲得
**「レポート」** → **「ライフサイクル」** → **「集客」** → **「トラフィック獲得」**
- Organic Search（Google検索など）
- Direct（直接アクセス）
- Referral（他サイトからのリンク）
- Social（SNSからのアクセス）

#### ページとスクリーン
**「レポート」** → **「ライフサイクル」** → **「エンゲージメント」** → **「ページとスクリーン」**
- 人気記事ランキング
- ページビュー数
- 平均滞在時間
- 直帰率

### 4-2. 確認推奨タイミング

| タイミング | 確認内容 |
|-----------|----------|
| **今すぐ** | リアルタイムレポート |
| **24時間後** | 初回データが溜まったか確認 |
| **3日後** | 流入元の傾向を確認 |
| **1週間後** | 人気記事ランキングを確認 |
| **1ヶ月後** | 月次レポートを作成 |

---

## トラブルシューティング

### ❌ リアルタイムレポートにユーザーが表示されない

#### 原因1: デプロイがまだ完了していない
**解決**: GitHub Actions で緑色のチェックマークを確認

#### 原因2: ブラウザキャッシュが残っている
**解決**: 強制リロード
- Windows / Linux: `Ctrl + Shift + R`
- Mac: `Cmd + Shift + R`

#### 原因3: 広告ブロッカーが有効
**解決**: 広告ブロッカーを一時的に無効にして確認
- uBlock Origin
- AdBlock Plus
- Brave ブラウザのシールド

**確認方法**:
1. 広告ブロッカーのアイコンをクリック
2. 「このサイトでは無効」を選択
3. ページをリロード

#### 原因4: 測定IDが間違っている
**解決**: _config.yml を確認
```bash
cd /Users/norio/my-project/n-nishizaki.github.io
grep -A 2 "analytics:" _config.yml
```

期待される出力:
```yaml
analytics:
  google:
    id: G-X1XJMK7DX6
```

### ❌ 開発者ツールでエラーが出る

**エラー例**:
```
Failed to load resource: net::ERR_BLOCKED_BY_CLIENT
```

**原因**: 広告ブロッカーが gtag.js をブロック

**解決**:
1. 広告ブロッカーの設定を開く
2. ホワイトリスト（例外リスト）に追加:
   ```
   n-nishizaki.github.io
   ```
3. ページをリロード

### ❌ 24時間経ってもレポートが表示されない

#### 確認事項
- [ ] リアルタイムレポートでユーザーが表示されるか
- [ ] ブログへのアクセス数が十分か（最低10セッション以上）
- [ ] データ保持設定が有効か

#### データ保持設定の確認
1. GA管理画面 → **「管理」**（左下の歯車アイコン）
2. **「データ設定」** → **「データ保持」**
3. **「イベントデータの保持」** が **「14か月」** になっているか確認

---

## 次のステップ: Google Search Console の設定

Google Analytics の設定が完了したら、次は **Google Search Console** を設定します。

### Google Search Console でできること
- どのキーワードで検索されているか
- 検索結果での表示回数とクリック率
- Google にインデックスされているページ数
- サイトマップの送信と管理

### 準備が整っているもの
- ✅ sitemap.xml（Phase 1で追加済み）
- ✅ robots.txt（Phase 1で追加済み）
- ✅ Google Analytics（Phase 2で設定完了）

**次回の作業**: Phase 4（Google Search Console セットアップ）

---

## セットアップ完了チェックリスト

### Phase 1: sitemap & robots.txt
- ✅ Gemfile に jekyll-sitemap 追加
- ✅ bundle install 実行
- ✅ _config.yml に plugins 設定追加
- ✅ robots.txt 作成
- ✅ ビルド確認
- ✅ Git コミット & プッシュ

### Phase 2: Google Analytics
- ✅ GA アカウント作成完了
- ✅ プロパティ作成完了
- ✅ ウェブストリーム作成完了
- ✅ 測定ID取得完了（G-X1XJMK7DX6）
- ✅ _config.yml に測定ID追加
- ✅ Git コミット & プッシュ

### 動作確認（これから）
- [ ] GitHub Actions でデプロイ完了確認
- [ ] 開発者ツールで gtag リクエスト確認
- [ ] GA リアルタイムレポートでユーザー表示確認
- [ ] 24時間後、詳細レポート確認

---

## 参考リンク

### Google Analytics
- [管理画面](https://analytics.google.com/)
- [GA4 ヘルプセンター](https://support.google.com/analytics)
- [リアルタイムレポート解説](https://support.google.com/analytics/answer/9271392)

### ブログ
- [ブログURL](https://n-nishizaki.github.io/)
- [GitHub リポジトリ](https://github.com/n-nishizaki/n-nishizaki.github.io)
- [GitHub Actions](https://github.com/n-nishizaki/n-nishizaki.github.io/actions)

---

**最終更新**: 2026-02-17
**作成者**: Claude
**承認者**: オーナー
