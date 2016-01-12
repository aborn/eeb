# eeb
Elixir Extendable Blog, http://eeb.aborn.me/  
[![Build Status](https://travis-ci.org/aborn/eeb.svg)](https://travis-ci.org/aborn/eeb)  
eeb是elixir语言版本的一种静态博客生成器。对就的github项目为[https://github.com/aborn/eeb](https://github.com/aborn/eeb)。

## 源码安装
执行以下命令
```
git clone https://github.com/aborn/eeb.git
cd eeb
mix deps.get             # 安装依赖
mix run --no-halt        # 运行
```
命令执行完成后，在本地的4000端口监听http请求：
http://localhost:4000/index.html

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
2016-01-12
