defmodule Game.SummaryTest do
  use ExUnit.Case
  alias War.{Summary, Game}
  alias Cards.Deck
  alias Bets.Bets

  test "put summary happy path" do
    game = Game.new()

    {:ok, bet} =
      Bets.create_bet(%{
        "suit-croupier": "spade",
        "suit-player": "spade",
        "color-croupier": "black",
        "color-player": "black",
        "card-odd": "war"
      })

    game = Game.create_bet(game, bet)
    croupier_card = Deck.create_card("spade", "2")
    player_card = Deck.create_card("spade", "2")
    game = %Game{game | "croupier-card": croupier_card}
    game = %Game{game | "player-card": player_card}
    game = Game.play_round(game)

    summary = Summary.summary(game)
    assert true == summary."suit-player"
    assert true == summary."suit-croupier"
    assert true == summary."color-player"
    assert true == summary."color-croupier"
    assert true == summary."card-odd"
  end

  test "put summary all false path" do
    game = Game.new()

    {:ok, bet} =
      Bets.create_bet(%{
        "suit-croupier": "heart",
        "suit-player": "diamond",
        "color-croupier": "red",
        "color-player": "red",
        "card-odd": "war"
      })

    game = Game.create_bet(game, bet)
    croupier_card = Deck.create_card("spade", "3")
    player_card = Deck.create_card("spade", "2")
    game = %Game{game | "croupier-card": croupier_card}
    game = %Game{game | "player-card": player_card}
    game = Game.play_round(game)

    summary = Summary.summary(game)
    assert false == summary."suit-player"
    assert false == summary."suit-croupier"
    assert false == summary."color-player"
    assert false == summary."color-croupier"
    assert false == summary."card-odd"
  end
end
