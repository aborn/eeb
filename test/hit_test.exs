defmodule Eeb.HitTest do
  alias Eeb.Hit.Client

  use ExUnit.Case, async: true

  
  setup do
    status = Client.make_sure_hit_server_started()
    {:ok, status: status}
  end

  test "test hit", %{status: _} do
    assert Client.get_hits("a.html") == 0
    Client.hits("a.html")
    assert Client.get_hits("a.html") == 1
    Client.hits("a.html")
    Client.hits("a.html")
    assert Client.get_hits("a.html") == 3
  end
end
