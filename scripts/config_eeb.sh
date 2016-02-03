#!/usr/bin/env bash
cd "$(dirname "$0")"
cd ..
echo `pwd`
mix eeb.config duoshuo_short_name "eeb"
