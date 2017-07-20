defmodule InfoSys.Google do
  use GenServer
  alias InfoSys.Result

  def start_link(query, query_ref, owner, limit) do
    Task.start_link(fn -> fetch(query, query_ref, owner, limit) end)
  end

  def fetch("search " <> str, query_ref, owner, _limit) do
    url = "https://www.google.com/#q=#{URI.encode_www_form(str)}"
    results = [
      %Result{backend: "google", score: 90, text: "links about #{str}: #{url}"}
    ]
    send(owner, {:results, query_ref, results})
  end
  def fetch(_query, query_ref, owner, _limit) do
    send(owner, {:results, query_ref, []})
  end
end
