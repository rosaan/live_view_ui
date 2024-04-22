defmodule UI.Utils do
  @moduledoc false
  def cn(classes) do
    classes |> Enum.filter(fn x -> x != true and x != false end) |> Tails.merge() |> to_string()
  end

  def unique_id, do: "LV" <> Integer.to_string(36 ** 3 + :rand.uniform(36 ** 4), 36)
end
