# index
This is a blog test!这是测试博客！

## eeb
eeb means elixir earmark blog, githb [eeb](https://github.com/aborn/eeb)

## usage
1. install elixir env
2. deploy this project
3. write blog in post

## code style
This is a code
```elixir
  def to_html(text) when is_binary(text) do
    get_markdown_processor().to_html(text)
    |> pretty_codeblocks()
  end
```
