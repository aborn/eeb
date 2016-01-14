defmodule Eeb.Image do
  @moduledoc """
  处理博客图片
  """

  alias Eeb.BlogPath
  alias Eeb.BlogUtils

  @doc """
  确保html的图片目录存在，不存在则创建之
  """
  def make_sure_html_image_dir_exists() do
    imagePath = Path.join(BlogPath.html_path, "images")
    unless File.exists?(imagePath) do
      File.mkdir_p!(imagePath)
    end
  end

  def yank_images_from_origin() do
    make_sure_html_image_dir_exists()
    imageList = BlogUtils.get_blog_image_name_list()
    
    Enum.each(imageList, &(yank_each_image_item(&1)))
  end

  def yank_each_image_item_callback(src, des) do
    Hex.Shell.warn("Overwriting #{des} by #{src}")
    true
  end
  
  def yank_each_image_item(imageFile) do
    desPath = Path.join(get_destination_path(imageFile),
                        get_image_file_name_without_path_info(imageFile))
    imageFullPath = Path.join(BlogPath.post_path, imageFile)
    result = File.cp(imageFullPath, desPath, &(yank_each_image_item_callback(&1,&2))) 
    case result do
      :ok ->
        Hex.Shell.info("success: yank image #{imageFullPath} to #{desPath}")
      {:error, posix} ->
        Hex.Shell.error("error: yank image #{imageFullPath} to #{desPath} #{posix}")
    end
  end

  def get_image_file_name_without_path_info(imageFile) do
    String.split(imageFile, "/") |> List.last()
  end
  
  def get_destination_path(imageFile) do
    destinationPath = BlogPath.html_path
    if imageFile =~ ~r"^images/" do
      destinationPath = Path.join(BlogPath.html_path, "images")
    end
    destinationPath <> "/"
  end
end
