# eeb
Elixir Extendable Blog, http://eeb.popkit.org/  
[![Build Status](https://travis-ci.org/aborn/eeb.svg)](https://travis-ci.org/aborn/eeb)
[![Hex.pm Version](http://img.shields.io/hexpm/v/eeb.svg?style=flat)](https://hex.pm/packages/eeb)
[![Inline docs](http://inch-ci.org/github/aborn/eeb.svg)](http://inch-ci.org/github/aborn/eeb)
[![Coverage Status](https://coveralls.io/repos/aborn/eeb/badge.svg?branch=master&service=github)](https://coveralls.io/github/aborn/eeb?branch=master)   
Eeb is a blog platform, which write in elixir language.  
And it includes two parst:  
1. static blog generator;
2. webserver.

## Installation
Install and deploy eeb needs elixir env. (version 1.2+). Install elixir env, pls. ref [elixir installation](http://elixir-lang.org/install.html)。  
We provide the following two methods to install eeb after elixir env ready.
### using hex package source
**1.** create a new empty project  
```elixir
mix new eeb_blog
cd eeb_blog
```
**2.** modify mix.exs, add eeb dependency, and using eeb module  
```elixir
  def application do
    [applications: [:logger,:eeb]]
  end
  defp deps do
    [{:eeb, "~> 0.1.2"}]
  end
```
**3.** install dependency, finally, deploy it  
```
mix deps.get
mix eeb.deploy
```
after deployment success, it shows following message  
```
eeb running in http://localhost:4000/
```
So, you can visit eeb blog using web browser[http://localhost:4000/](http://localhost:4000/)

### using eeb_new installation kit
**1.** install eeb_new kit as following  
```
mix archive.install https://github.com/aborn/eeb/raw/master/installer/archives/eeb_new.ez
```
**2.** create a new eeb blog  
```
mix eeb.new eeb_blog
cd eeb_blog
```
**3.** install dependency, finally, deploy it  
```
mix deps.get
mix eeb.deploy
```

## daemon running
In linux platform, you can use screen to daemon eeb  
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

## 注意事项
**1.** 默认的markdown格式的文章目录为posts/  
改变这个目录，只需要执行 mix eeb.config blog\_path "path/to/your/markdown/file/dir"，例如：  
```
mix eeb.config blog_path "/Users/aborn/github/technotebook"
```
**2.** 生成的对应的.html静态文件目录为html/  
**3.** 图片从原来的.md文件对应目录或者其目录下的images目录拷贝到html/images目录  
**4.** 博客文件名以"_"开头的，将被当作草稿博客，不做转换。

## 相关Task命令
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
eeb采用cowboy默认端口号为：4000，想要改变默认端口号可以通过以下两种方式：
### 通过设置环境变量BLOG_PORT的值改变默认端口号
如下例中将端口号改为4001：  
```shell
 export BLOG_PORT=4001
```
### 通过mix eeb.config命令配置默认端口号
如下例子中将端口号改为4002:  
```
mix eeb.config blog_port 4002
```
注意：如果以上两种方式都设置了值，那以第一种为准!

## 项目更新于
2016-01-31
