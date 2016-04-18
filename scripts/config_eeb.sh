#!/usr/bin/env bash
cd "$(dirname "$0")"
cd ..
echo `pwd`
mix eeb.config blog_port 4001
mix eeb.config webhook_token eeb
mix eeb.config duoshuo_short_name "eeb"
mix eeb.config blog_path "/home/aborn/github/eeb/posts"
