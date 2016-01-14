defmodule Eeb.ConfigUtils do

  @eeb_version Mix.Project.config[:version]
  @eeb_project Mix.Project.config[:app]
  
  def version, do: @eeb_version

  def project, do: @eeb_project

  def build_config() do
    %Eeb.Config{
      version: version(),
      project: project()
    }
  end

  def update(config) do
    read()
    |> Keyword.merge(config)
    |> write()
  end

  def read() do
    case File.read(config_path()) do
      {:ok, binary} ->
        case decode_term(binary) do
          {:ok, term} -> term
          {:error, _} -> decode_elixir(binary)
        end
      {:error, _} ->
        []
    end
  end
  
  @doc """
  将key,value配置写入文件
  """
  def write(config) do
    string = encode_term(config)

    path = config_path()
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, string)
  end

  def config_path do
    Path.join(config_file_dir(), "eeb.config")
  end

  defp encode_term(list) do
    list
    |> Enum.map(&[:io_lib.print(&1) | ".\n"])
    |> IO.iodata_to_binary
  end

  defp decode_term(string) do
    {:ok, pid} = StringIO.open(string)
    try do
      consult(pid, [])
    after
      StringIO.close(pid)
    end
  end

  defp consult(pid, acc) when is_pid(pid) do
    case :io.read(pid, '') do
      {:ok, term}      -> consult(pid, [term|acc])
      {:error, reason} -> {:error, reason}
      :eof             -> {:ok, Enum.reverse(acc)}
    end
  end

  defp decode_elixir(string) do
    {term, _binding} = Code.eval_string(string)
    term
  end
  
  defp config_file_dir do
    Path.expand(System.get_env("EEB_HOME") || "~/.eeb")
  end
  
end
