defmodule Navigator.Helpers.Config do
  @moduledoc """
  Helpers to get generic configs
  """

  @otp_app :navigator

  @doc """
  Get max dimensions config
  """
  def get_max_dimensions do
    Application.fetch_env!(@otp_app, :max_dimensions)
  end
end
