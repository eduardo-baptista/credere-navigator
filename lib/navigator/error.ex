defmodule Navigator.Error do
  @moduledoc """
  Error struct
  """

  alias Ecto.Changeset

  @keys [:type, :content]
  @enforce_keys @keys

  defstruct @keys

  @typedoc """
  Error definition
  """
  @type t :: %__MODULE__{type: atom(), content: any()}

  @spec build(atom(), any()) :: t()
  @doc """
  Create new Error struct
  """
  def build(type, content) when is_atom(type) do
    %__MODULE__{
      type: type,
      content: content
    }
  end

  @spec build_with_changeset(Changeset.t()) :: t()
  @doc """
  Create new Error struct with changeset content
  """
  def build_with_changeset(%Changeset{} = changeset) do
    build(:bad_request, changeset)
  end
end
