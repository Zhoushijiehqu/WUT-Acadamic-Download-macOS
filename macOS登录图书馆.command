#!/bin/bash
# 使用独立的 Edge / Chrome 会话，验证码和二次验证由本人完成。
cd "$(dirname "$0")" || exit 1
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
for node in "${CAMPUS_NODE:-}" node "$HOME"/.nvm/versions/node/*/bin/node; do
    [ -n "$node" ] || continue
    if "$node" -e 'process.exit(Number.parseInt(process.versions.node, 10) >= 22 ? 0 : 1)' 2>/dev/null; then
        "$node" skill-src/scripts/login_credentials.js --check --config "$PWD/登录配置.private.json" || exit $?
        exec "$node" skill-src/scripts/browser_dl.js --login --credentials "$PWD/登录配置.private.json" --wait-user 240 --out "$PWD/papers" "$@"
    fi
done
printf '%s\n' '未找到 Node.js 22 或更新版本。安装后重试，或设置 CAMPUS_NODE。' >&2
exit 1
