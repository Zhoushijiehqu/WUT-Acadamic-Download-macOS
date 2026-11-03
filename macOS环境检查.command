#!/bin/bash
cd "$(dirname "$0")" || exit 1
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
printf '%s\n' '校园文献助手 macOS 环境检查（不会读取账号或连接学校）'
found_python=''
for python in "${CAMPUS_PYTHON:-}" "$PWD/.venv/bin/python" python3; do
    [ -n "$python" ] || continue
    if "$python" -c 'import sys; sys.exit(sys.version_info < (3, 10))' 2>/dev/null; then
        found_python="$python"
        printf 'Python：'; "$python" --version
        if "$python" -c 'import pypdf' 2>/dev/null; then
            printf '%s\n' 'PDF 核验依赖 pypdf：已安装'
        else
            printf '%s\n' 'PDF 核验依赖 pypdf：未安装（配置界面不需要）'
            printf '安装命令："%s" -m pip install -r "%s/requirements-dev.txt"\n' "$python" "$PWD"
        fi
        break
    fi
done
[ -n "$found_python" ] || printf '%s\n' 'Python：未找到 3.10 或更新版本，配置界面无法启动'
found_node=''
for node in "${CAMPUS_NODE:-}" node "$HOME"/.nvm/versions/node/*/bin/node; do
    [ -n "$node" ] || continue
    if "$node" -e 'process.exit(Number.parseInt(process.versions.node, 10) >= 22 ? 0 : 1)' 2>/dev/null; then
        found_node="$node"
        printf 'Node.js：'; "$node" --version
        break
    fi
done
[ -n "$found_node" ] || printf '%s\n' 'Node.js：未找到 22 或更新版本（浏览器辅助需要）'
if [ -x '/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge' ] || [ -x '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' ] || [ -x "$HOME/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" ] || [ -x "$HOME/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ] || { [ -n "${CAMPUS_BROWSER_EXE:-}" ] && [ -x "$CAMPUS_BROWSER_EXE" ]; }; then
    printf '%s\n' '浏览器：已找到 Edge / Chrome 或指定浏览器'
else
    printf '%s\n' '浏览器：未在常见位置找到 Edge / Chrome（浏览器辅助需要）'
fi
printf '%s\n' '实际学校登录与文献下载需要在当前网络下单独验证。'
[ -n "$found_python" ]
