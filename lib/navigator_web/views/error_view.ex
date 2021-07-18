defmodule NavigatorWeb.ErrorView do
  use NavigatorWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{content: %Changeset{} = changeset}) do
    %{errors: translate_errors(changeset)}
  end

  def render("error.json", %{content: content}) when is_binary(content) do
    %{error: content}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", translate_value(value))
      end)
    end)
  end

  defp translate_value({:array, _}), do: ""
  defp translate_value(value), do: to_string(value)
end
