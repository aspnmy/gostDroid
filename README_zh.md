# dev版本说明
- gostDroid master分支原作者4年(最后更新时间2019年4月)不更新了，
- dev分支是我自己更新的分支，主要和gost的版本保持一致
- 原版本:https://github.com/rankaiyx/gostDroid.git
- 为了方便管理，rankaiyx/gostDroid 的master分支已经删除了，避免拉库异常

# releases 版本说明
- gostDroid_apk_v1.0 是原作者4年前(最后更新时间2019年4月)分支对应的版本，gost版本为v1.9.0
- gostDroid_dev_apk_gost2.12.0_v2.5.0  系列是对应我自己dev分支的版本，_gost2.12.0代表支持gost官方v2.12.0版本，_v2.5.0为我维护的文件的apk版本号

# 群组
https://t.me/+eq8FgfNVNIY3NWNk

# gostDroid

[README](README.md) | [中文文档](README_zh.md)

gost是一个支持http和socks的代理服务器项目，由`ginuerzh`开发并开源。我的目的是为gost提供Android版本的支持。

[![API](https://img.shields.io/badge/API-19%2B-green.svg?style=plastic)](https://android-arsenal.com/api?level=19)
[![license](https://img.shields.io/github/license/switch-iot/hin2n.svg?style=plastic)](https://www.gnu.org/licenses/gpl-3.0)

### gostDroid是什么

- gostDroid是支持http和socks的安卓设备代理服务器软件
- 该APP不需要root
- 该APP暂时只支持安卓设备

### gostDroid使用方法
具体使用方法请查看上游说明 https://github.com/ginuerzh/gost


### 快速使用
- admin:123456@ 代理认证
- 协议支持：http2、socks、mwss(多路复用加密ws)
-  多用户认证：?secrets=secrets.txt
-  指定多DNS解析：?dns=dns.txt
```bash
# 单用户认证启动-支持https-wss、http2、sock5、mwss
gost -L=http+wss://admin:123456@:444 -L=http2://admin:123456@:443 -L=socks5://admin:123456@:1080 -L=mwss://admin:123456@:8080?path=/ws&rbuf=4096&wbuf=4096&compression=true
```

```bash
# 多用认证启动-支持https-wss、http2、sock5、mwss
gost -L=http+wss://:444?secrets=secrets.txt -L=http2://:443?secrets=secrets.txt -L=socks5://:1080?secrets=secrets.txt -L=mwss://:8080?secrets=secrets.txt?path=/ws&rbuf=4096&wbuf=4096&compression=true
```

```bash
# 单用户认证并支持单DNS服务解析-支持https-wss、http2、sock5、mwss
gost -L=http+wss://admin:123456@:444?dns=8.8.8.8,114.114.114.114,1.1.1.1:53/tcp,1.1.1.1:853/tls,https://1.0.0.1/dns-query -L=http2://admin:123456@:443?dns=8.8.8.8,114.114.114.114,1.1.1.1:53/tcp,1.1.1.1:853/tls,https://1.0.0.1/dns-query -L=socks5://admin:123456@:1080?dns=8.8.8.8,114.114.114.114,1.1.1.1:53/tcp,1.1.1.1:853/tls,https://1.0.0.1/dns-query -L=mwss://admin:123456@:8080?dns=8.8.8.8,114.114.114.114,1.1.1.1:53/tcp,1.1.1.1:853/tls,https://1.0.0.1/dns-query?path=/ws&rbuf=4096&wbuf=4096&compression=true
```


```bash
# 多用户认证并支持多DNS服务解析-支持https-wss、http2、sock5、mwss
gost -L=http+wss://:444?secrets=secrets.txt?dns=dns.txt -L=http2://:443?secrets=secrets.txt?dns=dns.txt -L=socks5://:1080?secrets=secrets.txt?dns=dns.txt -L=mwss://:8080?secrets=secrets.txt?dns=dns.txt?path=/ws&rbuf=4096&wbuf=4096&compression=true
```

### gostWeb_UI
- 如需要使用Web管理端管理gost-server，请使用下面项目

```git
https://github.com/aspnmy/gost-ui.git
```


特别注意的是，应用在后台运行可能会被安卓电量管理终止掉，因此，如果要后台运行，请将其添加进白名单。

### gostDroid 最新版本
gostDroid最新版本可在[release地址](https://github.com/aspnmy/gostDroid/releases)查看下载。
