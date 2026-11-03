# 本机登录配置与接力

## 文件与入口

完整项目提供 `macOS启动.command` 打开 127.0.0.1 配置页面；`macOS登录图书馆.command` 启动独立 Edge / Chrome 登录会话。需要 Node.js 22+，验证码、扫码与二次验证由用户完成。配置页面只保存配置，不能证明学校认证或文章访问成功。

macOS 当前将账号和密码明文保存在项目根目录 `登录配置.private.json`，程序尝试将文件权限限制为当前用户；不使用钥匙串。不要提交、分享、打印或复制该文件到 skill 目录，独立安装时仅在用户授权后指定私密文件路径。旧 Windows 加密凭据不能在 Mac 上解密；不要删除或覆盖已有密文，应由用户在原 Windows 环境处理。

```bash
# 在完整项目根目录执行；检查不会显示凭据，也不会联网
node skill-src/scripts/login_credentials.js --check --config "登录配置.private.json"
node skill-src/scripts/browser_dl.js --login --credentials "登录配置.private.json" --wait-user 240
```

仅在宿主允许浏览器自动化时运行该脚本；如受限，由用户本机运行，不以此规避限制。独立浏览器的会话与用户日常浏览器和宿主内置浏览器互不共享。

## 行为边界

脚本只向 `https://webvpn.whut.edu.cn` 和 `https://zhlgd.whut.edu.cn` 的可见登录框输入。遇到其他域名、不安全表单或无法识别的页面时停止，不扩大白名单。账号密码不作为命令行参数、页面脚本或日志输出。

默认 `auto_submit:false`，填完后由用户完成验证码并点击登录；用户启用自动提交后，仅在无可见验证码时尝试点击一次。出现验证码、扫码或二次验证仍由用户完成；失败后不要重复尝试错误密码。

配置可读不等于认证成功。完成登录后，在同一浏览器访问实际文章并检查权限。默认独立 profile 位于 `~/.dsh/campus-papers/browser-profile`，CDP 端口为 9333。接力时只记录目标 DOI、浏览器、步骤和输出目录，不导出 Cookie 或记录账号密码。

离线测试覆盖配置读取、脱敏状态、域名和表单来源限制、填表与验证码暂停；学校当前认证页面和全文访问仍需现场验收。
