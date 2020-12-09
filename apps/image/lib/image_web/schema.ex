defmodule ImageWeb.Schema do
  use Absinthe.Schema
  import Ecto.Query
  alias Image.Repo

  @desc "An item"
  object :image do
    field(:id, non_null(:id))
    field(:url, :string)
  end

  query do
    field :images, non_null(list_of(non_null(:image))) do
      arg(:ids, non_null(list_of(non_null(:id))))

      resolve(fn %{ids: ids}, _ ->
        images = Repo.all(from i in Image.Image, where: i.id in ^ids)
        {:ok, images}
      end)
    end
  end
end
