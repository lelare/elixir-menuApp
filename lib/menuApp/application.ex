defmodule MenuApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MenuAppWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:menuApp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MenuApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MenuApp.Finch},
      # Start a worker by calling: MenuApp.Worker.start_link(arg)
      # {MenuApp.Worker, arg},
      # Start to serve requests, typically the last entry
      MenuAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MenuApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MenuAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
