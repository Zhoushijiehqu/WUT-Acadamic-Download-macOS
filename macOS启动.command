#!/bin/bash
# 从 Finder 双击运行，工作目录始终是项目所在目录。
cd "$(dirname "$0")" || exit 1

for python in "${CAMPUS_PYTHON:-}" "$PWD/.venv/bin/python" python3; do
    [ -n "$python" ] || continue
    if "$python" -c 'import sys; sys.exit(sys.version_info < (3, 10))' 2>/dev/null; then
        exec "$python" campus_portal.py "$@"
    fi
done
printf '%s\n' '未找到 Python 3.10 或更新版本。请安装 Python 后重试。' >&2
exit 1
