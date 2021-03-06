defmodule Geolix.Record.Subdivision do
  @moduledoc """
  Record for `subdivision` information.
  """

  @behaviour Geolix.Model

  defstruct [
    :geoname_id,
    :iso_code,
    :name,
    :names
  ]

  def from(nil, _), do: nil

  def from(data, locale) when is_list(data) do
    data |> Enum.map(&from(&1, locale))
  end

  def from(data, nil), do: struct(__MODULE__, data)

  def from(data, locale) do
    result = from(data, nil)
    result = Map.put(result, :name, result.names[locale])

    result
  end
end
