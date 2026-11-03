# 校园网与学校入口

需要判断校内直连、CARSI、WebVPN 或配置诊断时读此文件。以下入口来自用户原包，本轮仅离线审查，未重新联网核实可用性、订阅范围或学校政策。

| 用途 | 原包入口 |
|---|---|
| 图书馆 | `https://lib.whut.edu.cn/` |
| WebVPN | `https://webvpn.whut.edu.cn/login` |
| 统一认证候选入口 | `https://webvpn.whut.edu.cn/login?cas_login=true` |
| 学校 CARSI 门户 | `http://carsi.whut.edu.cn/` |
| 学校 IdP 标识 | `https://idp.whut.edu.cn/idp/shibboleth` |
| 数据库导航候选 | `https://wisdom.chaoxing.com/newwisdom/doordatabase/database.html?pageId=527321&wfwfid=25279&websiteId=285586&dataType=100001` |

优先学校门户上当前显示的入口，不凭旧 DNS、旧 IP、旧导航参数判断网络。原包链接中的 `uid` 含义未知，已从默认配置移除；如果导航需要其他参数，应从当前图书馆入口重新取得。

## 诊断与认证

macOS 版本不包含原 Windows 网络诊断功能，不能自动判断校园网、代理出口或 WebVPN 登录状态。网页可达、IP 或机构名称均不足以证明目标全文已授权；应在实际使用的浏览器中检查目标文章及 PDF。

通过学校当前入口选择 CARSI 或 WebVPN；[本机登录配置与接力](login-handoff.md)说明独立浏览器登录。验证码、扫码和二次验证由用户操作。CARSI 通常形成数据库侧机构会话，WebVPN 是代理页面，两者的登录结果不能互相推定。

不要覆盖用户的 `config.json`、删除浏览器 profile 或移动已有论文。
