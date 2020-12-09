defmodule Image.Repo.Migrations.AddImagesTable do
  use Ecto.Migration

  def change do
    create table("images") do
      add :url, :string, default: ""
      timestamps
    end
  end
end
