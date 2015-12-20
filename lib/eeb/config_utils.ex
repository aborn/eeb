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
  
end
