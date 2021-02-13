defmodule War.Summary do
  @moduledoc """
    Submodule to generate summary of Game
  """

  defstruct ~w"suit-player card-odd color-croupier color-player suit-croupier"a

  @spec summary(%War.Game{}) :: %__MODULE__{}
  def summary(game) do
    summary =
      game
      |> card_summary(:"player-card", :"suit-player", :suit)
      |> card_summary(:"croupier-card", :"suit-croupier", :suit)
      |> card_summary(:"player-card", :"color-player", :color)
      |> card_summary(:"croupier-card", :"color-croupier", :color)
      |> round_summary()
      |> Map.get(:summary)

    struct(__MODULE__, summary)
  end

  defp round_summary(game) do
    summary = Map.get(game, :summary, %{})
    bet_data = extract_bet(game, :"card-odd")
    card_odd = Map.get(game, :"card-odd")
    summary = Map.put(summary, :"card-odd", card_odd == bet_data)
    Map.put(game, :summary, summary)
  end

  defp card_data(game, card, position) do
    game
    |> Map.get(card)
    |> Map.get(position)
  end

  defp extract_bet(game, bet) do
    game
    |> Map.get(:bet)
    |> Map.get(bet)
  end

  defp card_summary(game, game_card, bet, position) do
    summary = Map.get(game, :summary, %{})
    card_data = card_data(game, game_card, position)
    bet_data = extract_bet(game, bet)
    summary = Map.put(summary, bet, card_data == bet_data)
    Map.put(game, :summary, summary)
  end
end
