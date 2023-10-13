defmodule PhoenixTwitter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixTwitterWeb.Telemetry,
      PhoenixTwitter.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_twitter, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixTwitter.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixTwitter.Finch},
      # Start a worker by calling: PhoenixTwitter.Worker.start_link(arg)
      # {PhoenixTwitter.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixTwitterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixTwitter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixTwitterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
