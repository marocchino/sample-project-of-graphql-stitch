defmodule Image.Repo do
  use Ecto.Repo,
    otp_app: :image,
    adapter: Ecto.Adapters.Postgres
end
