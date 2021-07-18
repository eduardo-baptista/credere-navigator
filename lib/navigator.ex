defmodule Navigator do
  @moduledoc """
  Navigator keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  defdelegate create_probe(params), to: Navigator.Probes.Create, as: :call
  defdelegate get_probe_by_id(id), to: Navigator.Probes.Get, as: :by_id
  defdelegate move_probe(id, movements), to: Navigator.Probes.Move, as: :call
  defdelegate reset_probe_position(id), to: Navigator.Probes.Reset, as: :call
end
