#!/bin/bash
set -euo pipefail

# Claude Code on the web のみ実行
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

BLOG_REPO="n-nishizaki/n-nishizaki.github.io"
BLOG_DIR="/home/user/n-nishizaki.github.io"

echo "=== Session Start Hook: tech-blog-monetization ==="

# ブログリポジトリのクローン / 更新
if [ ! -d "$BLOG_DIR/.git" ]; then
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    echo "ブログリポジトリをクローン中: ${BLOG_REPO}"
    git clone "https://${GITHUB_TOKEN}@github.com/${BLOG_REPO}.git" "$BLOG_DIR" --quiet
    git -C "$BLOG_DIR" config user.email "n-nishizaki@users.noreply.github.com"
    git -C "$BLOG_DIR" config user.name "n-nishizaki"
    echo "✅ ブログリポジトリのクローン完了: $BLOG_DIR"
  else
    echo "⚠️  GITHUB_TOKEN が未設定です"
    echo "   → Claude Code 設定 > Environment Variables > GITHUB_TOKEN を追加してください"
    echo "   → トークンには n-nishizaki.github.io への write 権限が必要です"
  fi
else
  echo "ブログリポジトリを最新化中..."
  git -C "$BLOG_DIR" pull --quiet
  echo "✅ ブログリポジトリの更新完了 ($BLOG_DIR)"
fi

# publish-ready の件数を表示
READY_COUNT=$(find "$CLAUDE_PROJECT_DIR/コンテンツ制作/publish-ready" -name "*.md" 2>/dev/null | wc -l)
if [ "$READY_COUNT" -gt 0 ]; then
  echo ""
  echo "📝 公開待ち記事: ${READY_COUNT} 件"
  find "$CLAUDE_PROJECT_DIR/コンテンツ制作/publish-ready" -name "*.md" | while read f; do
    echo "   - $(basename "$f")"
  done
fi

echo "=== セットアップ完了 ==="
