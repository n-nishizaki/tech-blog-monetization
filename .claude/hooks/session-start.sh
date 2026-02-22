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

# publish-ready vs _posts の差分チェック
PUBLISH_READY_DIR="$CLAUDE_PROJECT_DIR/コンテンツ制作/publish-ready"
POSTS_DIR="$BLOG_DIR/_posts"
UNPUBLISHED=()

if [ -d "$PUBLISH_READY_DIR" ] && [ -d "$POSTS_DIR" ]; then
  while IFS= read -r -d '' ready_file; do
    basename_ready="$(basename "$ready_file")"
    # _posts/ に同名ファイルが存在しなければ未公開
    if [ ! -f "$POSTS_DIR/$basename_ready" ]; then
      UNPUBLISHED+=("$basename_ready")
    fi
  done < <(find "$PUBLISH_READY_DIR" -name "*.md" -print0 2>/dev/null)
fi

UNPUBLISHED_COUNT=${#UNPUBLISHED[@]}
if [ "$UNPUBLISHED_COUNT" -gt 0 ]; then
  echo ""
  echo "📝 未公開記事: ${UNPUBLISHED_COUNT} 件"
  for f in "${UNPUBLISHED[@]}"; do
    echo "   - $f"
  done
  echo ""
  echo "   👉 公開するには: /blog-publish コンテンツ制作/publish-ready/<ファイル名>"
else
  READY_COUNT=$(find "$PUBLISH_READY_DIR" -name "*.md" 2>/dev/null | wc -l)
  if [ "$READY_COUNT" -gt 0 ]; then
    echo ""
    echo "✅ publish-ready の記事はすべて公開済みです"
  fi
fi

# ブログリポジトリの未コミット変更チェック
if [ -d "$BLOG_DIR/.git" ]; then
  UNCOMMITTED=$(git -C "$BLOG_DIR" status --porcelain 2>/dev/null)
  if [ -n "$UNCOMMITTED" ]; then
    echo ""
    echo "⚠️  ブログリポジトリに未コミットの変更があります:"
    git -C "$BLOG_DIR" status --short
    echo "   👉 必要に応じてコミット&プッシュしてください"
  fi
fi

echo "=== セットアップ完了 ==="
