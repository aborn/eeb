# eeb
Elixir Extendable Blog, http://eeb.aborn.me/  
[![Build Status](https://travis-ci.org/aborn/eeb.svg)](https://travis-ci.org/aborn/eeb)
[![Coverage Status](https://coveralls.io/repos/aborn/eeb/badge.svg?branch=master&service=github)](https://coveralls.io/github/aborn/eeb?branch=master)   
eeb是elixir语言版本的博客平台，它由两部分组成：博客生成器和webserver。

## 源码安装
执行以下命令
```
git clone https://github.com/aborn/eeb.git
cd eeb
mix deps.get             # 安装依赖
mix eeb.config blog_path "/Users/aborn/github/technotebook"  # 配置markdown文件目录，默认为项目根目录下的posts目录
mix eeb.blog             # 将posts/下的markdown文件转化成html文档
mix run --no-halt        # 本地运行/部署
```
交互式命令运行eeb
```
iex -S mix
```
命令执行完成后，在本地的4000端口(默认为cowboy的监控端口号)监听http请求：  
http://localhost:4000/index.html  

利用screen作为后台daemon
```
screen mix run --no-halt     #C-a d
# screen -ls
# screen -r id
```

## Github Webhooks
当你的博客文章放在自己github的某个项目里，这个功能就很有用。比如，你更新了博客或者添加了新博客
这时想让eeb及时地更新博客文章，在github的项目配置里找到Webhooks的配置，添加如下Payload URL：  
```
http://aborn.me/github.json?token=xxx
```
我的eeb博客部署在aborn.me这台服务器上，你把以上链接改成你自己部署的服务器链接：
注意这里的token值xxx改成你自己通过mix eeb.config配置的值：  
```
mix eeb.config webhook_token xxx
```

## 注意
**1.** 默认的markdown格式的文章目录为posts/  
改变这个目录，只需要执行 mix eeb.config blog\_path "path/to/your/markdown/file/dir"，例如：  
```
mix eeb.config blog_path "/Users/aborn/github/technotebook"
```
**2.** 生成的对应的.html静态文件目录为html/  
**3.** 图片从原来的.md文件对应目录或者其目录下的images目录拷贝到html/images目录

## 相关命令
```mix
mix eeb          ## print eeb help info
mix eeb.blog     ## generate blogs from posts/ dir to html/
mix eeb.index    ## generate/regenerate this index.html file for blog
mix eeb.config   ## Reads or update eeb config
```

## 项目更新于
2016-01-19
