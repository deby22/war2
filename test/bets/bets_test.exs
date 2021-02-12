defmodule Bets.BetsTest do
  use ExUnit.Case
  alias Bets.Bets
  doctest War

  test "create bet when given valid suit-player" do
    {:ok, bet} = Bets.create_bet(%{"suit-player": "diamond"})
    assert "diamond" == bet."suit-player"

    {:ok, bet} = Bets.create_bet(%{"suit-player": "heart"})
    assert "heart" == bet."suit-player"

    {:ok, bet} = Bets.create_bet(%{"suit-player": "club"})
    assert "club" == bet."suit-player"

    {:ok, bet} = Bets.create_bet(%{"suit-player": "spade"})
    assert "spade" == bet."suit-player"
  end

  test "create bet when givven invalid suit-plyer" do
    {:errors, [message]} = Bets.create_bet(%{"suit-player": "invalid"})
    assert "Invalid suit-player. Allowed: [heart diamond club spade]" == message
  end

  test "create bet when given valid card-odd and suit-croupier" do
    {:ok, bet} = Bets.create_bet(%{"suit-croupier": "diamond"})
    assert "diamond" == bet."suit-croupier"

    {:ok, bet} = Bets.create_bet(%{"suit-croupier": "heart"})
    assert "heart" == bet."suit-croupier"

    {:ok, bet} = Bets.create_bet(%{"suit-croupier": "club"})
    assert "club" == bet."suit-croupier"

    {:ok, bet} = Bets.create_bet(%{"suit-croupier": "spade"})
    assert "spade" == bet."suit-croupier"
  end

  test "create bet when given invalid suit-croupier" do
    {:errors, [message]} = Bets.create_bet(%{"suit-croupier": "invalid"})
    assert "Invalid suit-croupier. Allowed: [heart diamond club spade]" == message
  end

  test "create bet when given valid color player" do
    {:ok, bet} = Bets.create_bet(%{"color-player": "black"})
    assert "black" == bet."color-player"
    {:ok, bet} = Bets.create_bet(%{"color-player": "red"})
    assert "red" == bet."color-player"
  end

  test "create bet when given invalid color player" do
    {:errors, [message]} = Bets.create_bet(%{"color-player": "invalid"})
    assert "Invalid color-player. Allowed: [black red]" == message
  end

  test "create bet when given valid color croupier" do
    {:ok, bet} = Bets.create_bet(%{"color-croupier": "black"})
    assert "black" == bet."color-croupier"
    {:ok, bet} = Bets.create_bet(%{"color-croupier": "red"})
    assert "red" == bet."color-croupier"
  end

  test "create bet when given invalid color croupier" do
    {:errors, [message]} = Bets.create_bet(%{"color-croupier": "invalid"})
    assert "Invalid color-croupier. Allowed: [black red]" == message
  end

  test "create bet when given valid card-odd" do
    {:ok, bet} = Bets.create_bet(%{"card-odd": "player"})
    assert "player" == bet."card-odd"
    {:ok, bet} = Bets.create_bet(%{"card-odd": "croupier"})
    assert "croupier" == bet."card-odd"
    {:ok, bet} = Bets.create_bet(%{"card-odd": "war"})
    assert "war" == bet."card-odd"
  end

  test "create bet when given invalid card-odd" do
    {:errors, [message]} = Bets.create_bet(%{"card-odd": "invalid"})
    assert "Invalid card-odd. Allowed: [player croupier war]" == message
  end

  test "create bet witout any position" do
    {:errors, [message]} = Bets.create_bet(%{})
    assert "At least one bet is required." == message
  end

  # test "bet summary with all positive" do
  #   {:ok, bet} =
  #     Bets.create_bet(%{
  #       "card-odd": "player",
  #       "suit-player": "diamond",
  #       "color-croupier": "red",
  #       "color-player": "red",
  #       "suit-croupier": "diamond"
  #     })

  #   player_card = %{color: "red", suit: "diamond"}
  #   croupier_card = %{color: "red", suit: "diamond"}
  #   card_odd = "player"
  #   summary = Bets.summary(bet, player_card, croupier_card, card_odd)
  #   assert summary."card-odd" == true
  #   assert summary."suit-player" == true
  #   assert summary."suit-croupier" == true
  #   assert summary."color-player" == true
  #   assert summary."color-croupier" == true
  # end

  # test "bet summary with all negative" do
  #   {:ok, bet} =
  #     Bets.create_bet(%{
  #       "card-odd": "war",
  #       "suit-player": "club",
  #       "color-croupier": "black",
  #       "color-player": "black",
  #       "suit-croupier": "spade"
  #     })

  #   player_card = %{color: "red", suit: "diamond"}
  #   croupier_card = %{color: "red", suit: "diamond"}
  #   card_odd = "player"
  #   summary = Bets.summary(bet, player_card, croupier_card, card_odd)
  #   assert summary."card-odd" == false
  #   assert summary."suit-player" == false
  #   assert summary."suit-croupier" == false
  #   assert summary."color-player" == false
  #   assert summary."color-croupier" == false
  # end
end
