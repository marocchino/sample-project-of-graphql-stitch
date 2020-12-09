defmodule ImageWeb.Schema do
  use Absinthe.Schema

  @desc "An item"
  object :image do
    field(:id, non_null(:id))
    field(:url, :string)
  end

  query do
    field :images, non_null(list_of(non_null(:image))) do
      arg(:ids, non_null(list_of(non_null(:id))))

      resolve(fn %{ids: _}, _ ->
        {:ok, [%{id: 1, url: "url1"}, %{id: 2, url: "url2"}]}
      end)
    end
  end
end
