# 博客标题
这是一篇测试博客

## eeb
Eeb is elixir extensible static blog generator, github [eeb](https://github.com/aborn/eeb).

## 安装方法
使用以下步骤
1. 安装elixir语言环境
2. mix deps.get 
3. 写博客
4. mix eeb.blog

## code style
This is a code
```
def get_template_footer() do
    config = ConfigUtils.build_config()
    Templates.footer_template(config)
end
```

## BLOCKQUOTES
Blockquote test
> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
> 
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
> id sem consectetuer libero luctus adipiscing.

## EMPHASIS
*single asterisks*

_single underscores_

**double asterisks**

__double underscores__
