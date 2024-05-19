defmodule LiveViewUI.UI.Helper do
  @moduledoc """
  Provides utility functions for handling UI elements within LiveView components.
  """

  @doc """
  Converts a list of CSS class names into a single string with unique classes only.

  ## Parameters

  - `classes`: A list of strings representing CSS class names, potentially with duplicates.

  ## Examples

      iex> LiveViewUI.UI.cn(["button", "active", "button"])
      "active button"

  ## Returns

  - A string containing unique class names, sorted and joined by spaces.
  """
  def cn(classes) do
    classes
    |> Enum.filter(fn x -> x != true and x != false end)
    |> Tails.merge()
    |> to_string()
  end

  @doc """
  Generates a unique identifier for a LiveView component.

  ## Examples

      # Example of a typical unique identifier output
      iex> id = LiveViewUI.UI.unique_id()
      iex> String.starts_with?(id, "LV")
      true
      iex> byte_size(id)
      6

  ## Returns

  - A string starting with "LV" followed by a unique alphanumeric sequence.
  """
  def unique_id do
    "LV" <> Integer.to_string(36 ** 3 + :rand.uniform(36 ** 4), 36)
  end
end
