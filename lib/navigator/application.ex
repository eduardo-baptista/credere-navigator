defmodule Navigator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Navigator.Repo,
      # Start the Telemetry supervisor
      NavigatorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Navigator.PubSub},
      # Start the Endpoint (http/https)
      NavigatorWeb.Endpoint
      # Start a worker by calling: Navigator.Worker.start_link(arg)
      # {Navigator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Navigator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NavigatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
