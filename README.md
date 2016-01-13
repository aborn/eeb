# eeb
Elixir Extendable Blog, http://eeb.aborn.me/  
[![Build Status](https://travis-ci.org/aborn/eeb.svg)](https://travis-ci.org/aborn/eeb)  
eeb是elixir语言版本的博客平台，它由两部分组成：博客生成器和webserver。

## 源码安装
执行以下命令
```
git clone https://github.com/aborn/eeb.git
cd eeb
mix deps.get             # 安装依赖
mix eeb.blog             # 将posts/下的markdown文件转化成html文档
mix run --no-halt        # 运行/部署
```
如果想做为daemon 
```
nohup mix --no-halt >>nohup.out 2>&1
```
命令执行完成后，在本地的4000端口监听http请求：
http://localhost:4000/index.html  
如[http://eeb.aborn.me:4000/index.html](http://eeb.aborn.me:4000/index.html)

## 通过hex安装源安装[暂时不支持]

1. 
If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add eeb to your list of dependencies in `mix.exs`:
```elixir
def deps do
    [{:eeb, "~> 0.0.1"}]
end
```
2. Ensure eeb is started before your application:
```elixir
def application do
    [applications: [:eeb]]
end
```

## 使用
```mix
mix eeb          ## print eeb help info
mix eeb.blog     ## generate blogs from posts/ dir to html/
mix eeb.index    ## generate/regenerate this index.html file for blog
```

## 项目更新于
2016-01-13
