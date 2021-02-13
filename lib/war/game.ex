defmodule War.Game do
  @moduledoc """
    Core domain Game as state in Server
    Include basic operation
      new game
      create new bet
      shuffle deck of card
      grab player card
      grab croupier card
      play round
  """

  defstruct [
    :"player-card",
    :"croupier-card",
    :"card-odd",
    cards: [],
    bet: %{},
    shuffled_times: 0
  ]

  alias Cards.{Card, Deck}
  alias Bets.Bet

  @spec new() :: %__MODULE__{cards: list(%Card{})}
  def new(), do: %__MODULE__{cards: Deck.create_deck()}

  @spec create_bet(%__MODULE__{}, %Bet{}) :: %__MODULE__{}
  def create_bet(game, bet), do: %__MODULE__{game | bet: bet}

  @spec shuffle_deck_of_card(%__MODULE__{}) :: %__MODULE__{}
  def shuffle_deck_of_card(game) do
    times = 30
    cards = Deck.shuffle(game.cards, times)
    game = %__MODULE__{game | cards: cards}
    %__MODULE__{game | shuffled_times: game.shuffled_times + times}
  end

  @spec grab_player_card(%__MODULE__{}) :: %__MODULE__{"player-card": %Card{}}
  def grab_player_card(game) do
    [grabbed | others] = game.cards
    game = %__MODULE__{game | cards: others}
    %__MODULE__{game | "player-card": grabbed}
  end

  @spec grab_croupier_card(%__MODULE__{}) :: %__MODULE__{"croupier-card": %Card{}}
  def grab_croupier_card(game) do
    [grabbed | others] = game.cards
    game = %__MODULE__{game | cards: others}
    %__MODULE__{game | "croupier-card": grabbed}
  end

  @spec play_round(%__MODULE__{}) :: %__MODULE__{"card-odd": String.t()}
  def play_round(game) do
    %__MODULE__{game | "card-odd": do_play_round(game)}
  end

  @spec do_play_round(%__MODULE__{}) :: String.t()
  defp do_play_round(game) do
    player = game."player-card"
    croupier = game."croupier-card"

    cond do
      croupier.power > player.power -> "croupier"
      croupier.power < player.power -> "player"
      croupier.power == player.power -> "war"
    end
  end
end
