# eeb
Elixir Extendable Blog, http://eeb.aborn.me/  
[![Build Status](https://travis-ci.org/aborn/eeb.svg)](https://travis-ci.org/aborn/eeb)

## Installation

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

## Usage
```mix
mix eeb          ## print eeb help info
mix eeb.blog     ## generate blogs from posts/ dir to html/
mix eeb.index    ## generate/regenerate this index.html file for blog
```

## Update
2016-01-10
