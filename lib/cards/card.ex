defmodule Cards.Card do
  @moduledoc false

  @enforce_keys [:color, :suit, :value]
  defstruct [:color, :suit, :value, :power]

  @spec new(String.t(), String.t()) :: %__MODULE__{}
  def new(suit, value) do
    %Cards.Card{
      suit: suit,
      value: value,
      power: get_power_by_value(value),
      color: get_color_by_suit(suit)
    }
  end

  defp get_color_by_suit(suit) do
    case suit do
      "heart" -> "red"
      "diamond" -> "red"
      "club" -> "black"
      "spade" -> "black"
    end
  end

  defp get_power_by_value(value) when value == "A", do: 11
  defp get_power_by_value(value) when value in ["J", "Q", "K"], do: 10

  defp get_power_by_value(value) when value in ~w"2 3 4 5 6 7 8 9 10",
    do: String.to_integer(value)
end
