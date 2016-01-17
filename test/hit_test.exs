defmodule Eeb.HitTest do
  alias Eeb.HitClient

  use ExUnit.Case, async: true

  
  setup do
    status = HitClient.make_sure_hit_server_started()
    {:ok, status: status}
  end

  test "test hit", %{status: _} do
    assert HitClient.get_hits("a.html") == 0
    HitClient.hits("a.html")
    assert HitClient.get_hits("a.html") == 1
    HitClient.hits("a.html")
    HitClient.hits("a.html")
    assert HitClient.get_hits("a.html") == 3
  end
end
