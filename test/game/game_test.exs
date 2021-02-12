defmodule Game.GameTest do
  use ExUnit.Case
  alias Game.Game
  alias Cards.Deck
  doctest War

  test "create new_game empty Game" do
    game = Game.new()
    assert nil == game.bet
  end

  test "put bet if there was no bet before" do
    bet = %{"card-odd": "war"}
    game = Game.new()
    game = Game.create_bet(game, bet)
    assert "war" == game.bet."card-odd"
  end

  test "game shuffle deck of card at least 30 times" do
    game = Game.new()
    game = Game.shuffle_deck_of_card(game)
    assert 30 == game.shuffled_times
    assert 260 = Enum.count(game.cards)
  end

  test "grab user card should set player card and returns others 259 cards" do
    bet = %{"card-odd": "croupier"}
    game = Game.new()
    game = Game.create_bet(game, bet)
    card = Enum.at(game.cards, 0)
    game = Game.grab_player_card(game)
    assert game.player_card == card
    assert 259 == Enum.count(game.cards)
  end

  test "grab croupier card should set croupier card and returns others 259 cards" do
    bet = %{"card-odd": "croupier"}
    game = Game.new()
    game = Game.create_bet(game, bet)
    card = Enum.at(game.cards, 0)
    game = Game.grab_croupier_card(game)
    assert game.croupier_card == card
    assert 259 == Enum.count(game.cards)
  end

  test "play round when player win" do
    game = Game.new()
    croupier_card = Deck.create_card("spade", "2")
    player_card = Deck.create_card("spade", "3")
    game = %Game{game | croupier_card: croupier_card}
    game = %Game{game | player_card: player_card}
    assert "player" == Game.play_round(game)
  end

  test "play round when croupier win" do
    game = Game.new()
    croupier_card = Deck.create_card("spade", "4")
    player_card = Deck.create_card("spade", "3")
    game = %Game{game | croupier_card: croupier_card}
    game = %Game{game | player_card: player_card}
    assert "croupier" == Game.play_round(game)
  end

  test "play round when draw" do
    game = Game.new()
    croupier_card = Deck.create_card("spade", "2")
    player_card = Deck.create_card("spade", "2")
    game = %Game{game | croupier_card: croupier_card}
    game = %Game{game | player_card: player_card}
    assert "war" == Game.play_round(game)
  end
end
