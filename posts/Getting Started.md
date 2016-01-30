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
    [{:eeb, "~> 0.1.3"}]
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
When your blog in github another repo. This function is very usefully. For example,
when you create or update an blog, you want eeb to update your blog immediately.
What's should you do? Just config a webhooks on your blog repo, and add following
payload URL：  
```
http://your-blog-domain.com/github.json?token=xxx
```
Here, the value of token parameter xxx should configured as following:  
```
mix eeb.config webhook_token xxx
```

## Hints
**1.** default markdown format blog directory is posts/  
You can configure by mix eeb.config blog\_path "path/to/your/markdown/file/dir", for example：  
```
mix eeb.config blog_path "/Users/aborn/github/technotebook"
```
**2.** the static *.html files directory is html/  
**3.** the images in html/images  
**4.** the blog with file name starting with "_" will be regarded as draft, and won't be converted.

## The tasks command
```mix
mix eeb        # Show the help command info.
mix eeb.blog   # Generate static blogs from markdown files (in posts/ directory).
mix eeb.config # Reads or update eeb config.
mix eeb.deploy # Starts the eeb application.
mix eeb.index  # Generate/Regenerate blog index.html file.
```

## Configuration
mix eeb.config key [value], the keys show as following:  
```
blog_path - blog file path
blog_name - blog name config
blog_slogan - blog slogan config
blog_avatar - blog avatar image config
webhook_token - use as token verify when github webhook request
blog_port - blog http listening port number
```

## Http listen port
eeb use cowboy default http port 4000  
Using one of folling method to change the http port:  
### BLOG_PORT environment variable
following is an example:  
```shell
 export BLOG_PORT=4001
```
### mix eeb.config
following is an example:  
```
mix eeb.config blog_port 4002
```
But, the first one will be work if you use both method.

## Update date
2016-01-31
