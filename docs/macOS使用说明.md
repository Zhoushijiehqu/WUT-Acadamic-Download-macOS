# macOS 使用说明

本项目由本机配置门户、论文获取与核验工具及智能体 skill 组成。macOS 提供 Finder 双击入口；此前 Windows 专用的校园网络和代理诊断未包含在当前版本中。配置门户只负责保存账号，学校认证及逐篇下载是后续独立步骤。

## 启动配置页面

1. 安装 Python 3.10 或更新版本。双击项目根目录的 **macOS环境检查.command** 可查看本机环境；配置界面无需额外 Python 依赖。
2. 双击 **macOS启动.command**，在自动打开的浏览器页面填写配置。首次启动如被 macOS 拦截，可在 Finder 右键选择“打开”，或在终端进入项目目录运行 `./macOS启动.command`。
3. 使用期间保持终端窗口开启；按 Control-C 可停止。可在终端运行 `./macOS启动.command --demo` 体验不读取、不保存账号的演示界面。

启动入口先尝试环境变量 `CAMPUS_PYTHON` 指定的解释器，再尝试项目 `.venv`，最后尝试 `python3`。已有虚拟环境若来自另一台电脑，可能需要重新创建；无需为了打开界面安装额外依赖。

## 登录及下载

浏览器辅助需要 Node.js 22 或更新版本，以及本机 Edge 或 Chrome。先在配置页面保存账号，再双击 **macOS登录图书馆.command**。它会打开独立浏览器会话，不自动共享你日常浏览器的登录状态；验证码和二次验证由本人完成，终端窗口请保持开启。若 Node.js 安装在不常见的位置，可在终端设置 `CAMPUS_NODE` 为其可执行文件路径后运行该入口。

逐篇下载仍使用浏览器辅助命令，或由支持的智能体宿主接续；示例命令及用途见项目根目录 README。校园认证成功、文章权限和 PDF 核验是不同状态，实际可用性需在学校网络和目标文章上验证。

## PDF 核验

配置门户不需要第三方 Python 包。需要本地 PDF 内容和篇目核验时，在项目目录执行环境检查所提示的安装命令，例如：

```bash
python3 -m pip install -r requirements-dev.txt
```

安装到与下载工具实际使用的同一个 Python 环境中。如果系统 Python 不允许安装包，可以先执行 `python3 -m venv .venv`，再运行 `.venv/bin/python -m pip install -r requirements-dev.txt`。

## 账号文件

macOS 下当前配置保存在项目根目录的 `登录配置.private.json`：该文件是本地明文，程序尝试将权限设为仅当前用户可读写，**并未使用 macOS 钥匙串加密**。不要将它发给他人或加入版本控制。删除此文件会移除已保存的账号配置；浏览器独立会话还可能保留登录状态，存于 `~/.dsh/campus-papers/browser-profile`，按需自行清理。
