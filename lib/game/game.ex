defmodule Game.Game do
  defstruct [
    :"player-card",
    :"croupier-card",
    :"card-odd",
    cards: [],
    bet: %{},
    shuffled_times: 0
  ]

  alias Game.Game
  alias Cards.Deck

  def new(), do: %Game{cards: Deck.create_deck()}

  def create_bet(game, bet), do: %Game{game | bet: bet}

  def shuffle_deck_of_card(game) do
    # TODO: do przebudowy tak żeby shuffle wykonywało się raz
    times = 30
    cards = Deck.shuffle(game.cards, times)
    game = %Game{game | cards: cards}
    %Game{game | shuffled_times: game.shuffled_times + times}
  end

  def grab_player_card(game) do
    [grabbed | others] = game.cards
    game = %Game{game | cards: others}
    %Game{game | "player-card": grabbed}
  end

  def grab_croupier_card(game) do
    [grabbed | others] = game.cards
    game = %Game{game | cards: others}
    %Game{game | "croupier-card": grabbed}
  end

  def play_round(game) do
    %Game{game | "card-odd": do_play_round(game)}
  end

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
