# eeb
Elixir Extendable Blog, http://eeb.aborn.me/  
[![Build Status](https://travis-ci.org/aborn/eeb.svg)](https://travis-ci.org/aborn/eeb)
[![Coverage Status](https://coveralls.io/repos/aborn/eeb/badge.svg?branch=master&service=github)](https://coveralls.io/github/aborn/eeb?branch=master)   
eeb是elixir语言版本的博客平台，它由两部分组成：1. 静态博客生成器;2. webserver。

## elixir环境
安装和运行eeb需要elixir(版本1.0以上)语言环境，安装elixir见官方的[安装说明](http://elixir-lang.org/install.html)。

## 安装
安装eeb有以下两种方式：

### 通过hex依赖安装
**1.** 通过mix创建一个项目  
```elixir
mix new eeb_blog
cd eeb_blog
```
**2.** 修改项目的mix.exs文件，添加对eeb的依赖，同时加载eeb模块  
```elixir
  def application do
    [applications: [:logger,:eeb]]
  end
  defp deps do
    [{:eeb, "~> 0.1.2"}]
  end
```
**3.** 最后安装依赖到本地，然后部署eeb博客  
```
mix deps.get
mix eeb.deploy
```
部署完成后会显示  
```
eeb running in http://localhost:4000/
```
这时浏览器中打开http://localhost:4000/博客页面

### 通过eeb_new方式安装
**1.** 通过以下命令，安装eeb_new
```
mix archive.install https://github.com/aborn/eeb/raw/master/installer/archives/eeb_new.ez
```
**2.** 创建eeb博客
```
mix eeb.new eeb_blog
cd eeb_blog
```
**3.** 最后安装依赖到本地，然后部署eeb博客  
```
mix deps.get
mix eeb.deploy
```

## 后台部署
通过screen命令，将eeb作为后台daemon，这样退出terminal后会在后台运行  
```shell
screen mix eeb.deploy  # C-a d
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
mix eeb          ## 显示帮助信息.
mix eeb.blog     ## 将markdown格式博客生成静态html文件.
mix eeb.config   ## 读取或者更新博客的key/value的配置.
mix eeb.deploy   ## 运行和部署eeb博客.
mix eeb.index    ## 生成博客首页index.html文件.
```

## 相关配置
通过mix eeb.config key [value] 配置以下key对应的值:  
```
blog_path        ## 配置markdown文件目录（默认为posts/目录）.
blog_name        ## 配置博客名 (默认为:eeb).
blog_slogan      ## 配置博客签名（默认为:elixir extendable blog, aha!）.
blog_avatar      ## 配置博客头像.
webhook_token    ## 配置webhook的token.
```

## 端口号配置
eeb采用cowboy默认端口号为：4000,通过设置环境变量EEB_PORT的值，  
可改变端口号，如下例中将端口号改为4001：  
```shell
export EEB_PORT=4001
```

## 项目更新于
2016-01-29
