defmodule War.GameManagerTest do
  use ExUnit.Case
  alias War.{Game, GameManager}
  doctest War

  test "create new_game empty Game" do
    {:ok, game} = GameManager.new_game()
    assert %{} == game.bet
  end

  test "put bet if another exist should return error with information" do
    bet = %{"card-odd": "war"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:error, msg} = GameManager.create_bet(game, bet)
    assert "You couldn't put another bet" == msg
  end

  test "put bet if there was no bet before" do
    bet = %{"card-odd": "war"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    assert "war" == game.bet."card-odd"
  end

  test "put invalid bet should return error with information" do
    {:ok, game} = GameManager.new_game()
    {:error, [msg]} = GameManager.create_bet(game, %{})

    assert "At least one bet is required." == msg
  end

  test "put bet with few invalid key should return error with information" do
    bet = %{"card-odd": "invalid", "suit-croupier": "greem"}
    {:ok, game} = GameManager.new_game()
    {:error, msg} = GameManager.create_bet(game, bet)

    assert [
             "Invalid card-odd. Allowed: [player croupier war]",
             "Invalid suit-croupier. Allowed: [heart diamond club spade]"
           ] == msg
  end

  test "new_game game build deck built from 5 original decks of card" do
    {:ok, game} = GameManager.new_game()
    assert 260 == Enum.count(game.cards)
  end

  test "game shuffle deck of card at least 30 times" do
    bet = %{"card-odd": "croupier"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:ok, game} = GameManager.shuffle_deck_of_card(game)
    assert 260 = Enum.count(game.cards)
  end

  test "grab user card should set player power and returns others 259 cards" do
    bet = %{"card-odd": "croupier"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:ok, game} = GameManager.shuffle_deck_of_card(game)
    card = Enum.at(game.cards, 0)
    {:ok, game} = GameManager.grab_player_card(game)
    assert card == game."player-card"
    assert 259 == Enum.count(game.cards)
  end

  test "grab player card after user card should set croupier power and returns others 258 cards" do
    bet = %{"card-odd": "croupier"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:ok, game} = GameManager.shuffle_deck_of_card(game)
    {:ok, game} = GameManager.grab_player_card(game)
    card = Enum.at(game.cards, 0)
    {:ok, game} = GameManager.grab_croupier_card(game)
    assert card == game."croupier-card"
    assert 258 == Enum.count(game.cards)
  end

  test "grab croupier card before user card should return error and information" do
    bet = %{"card-odd": "croupier"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:ok, game} = GameManager.shuffle_deck_of_card(game)
    {:error, msg} = GameManager.grab_croupier_card(game)
    assert msg == "Player grab card first"
    assert 260 == Enum.count(game.cards)
  end

  test "player cannot grab two cards in a row" do
    bet = %{"card-odd": "croupier"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:ok, game} = GameManager.shuffle_deck_of_card(game)
    {:ok, game} = GameManager.grab_player_card(game)
    {:error, msg} = GameManager.grab_player_card(game)
    assert msg == "You can't grab another Card. Its croupier turn."
    assert 259 == Enum.count(game.cards)
  end

  test "game summary" do
    bet = %{"card-odd": "war"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:ok, game} = GameManager.shuffle_deck_of_card(game)
    {:ok, game} = GameManager.grab_player_card(game)
    {:ok, game} = GameManager.grab_croupier_card(game)
    player_card = Cards.Deck.create_card("spade", "3")
    croupier_card = Cards.Deck.create_card("spade", "3")
    game = %Game{game | "player-card": player_card}
    game = %Game{game | "croupier-card": croupier_card}
    game = Game.play_round(game)
    {:ok, summary} = GameManager.game_summary(game)
    assert true == summary."card-odd"
    assert false == summary."color-croupier"
    assert false == summary."color-player"
    assert false == summary."suit-croupier"
    assert false == summary."suit-player"
  end

  test "grab card before shuffling should return error" do
    bet = %{"card-odd": "croupier"}
    {:ok, game} = GameManager.new_game()
    {:ok, game} = GameManager.create_bet(game, bet)
    {:error, msg} = GameManager.grab_player_card(game)
    assert msg == "Shuffle card before game"
  end

  test "grab card before putting bet should return error" do
    {:ok, game} = GameManager.new_game()
    {:error, msg} = GameManager.grab_player_card(game)
    assert msg == "Shuffle card before game"
  end

  test "shuffling before generate bet should return error" do
    {:ok, game} = GameManager.new_game()
    {:error, msg} = GameManager.shuffle_deck_of_card(game)
    assert msg == "Put bet before shuffling cards"
  end
end
