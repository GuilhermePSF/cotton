defmodule Cotton.Repo do
  use Ecto.Repo,
    otp_app: :cotton,
    adapter: Ecto.Adapters.Postgres
end
