defmodule War.GameServerTest do
  use ExUnit.Case, async: true
  alias War.GameServer

  doctest War

  test "create valid bet with card-odd" do
    GameServer.start_link()
    GameServer.new_bet(%{"card-odd": "war"})
    bet = GameServer.get_bet()
    assert "war" == bet."card-odd"
    assert nil == bet."color-player"
  end

  test "send twice create bet should return error and dont override old bet" do
    GameServer.start_link()
    GameServer.new_bet(%{"card-odd": "war"})
    msg = GameServer.new_bet(%{"player-color": "red"})
    assert "You couldn't put another bet" == msg
    bet = GameServer.get_bet()
    assert "war" == bet."card-odd"
    assert nil == bet."color-player"
  end

  test "start game before create bet should return error" do
  end

  test "try to create bet with invalid key" do
    GameServer.start_link()
    msg = GameServer.new_bet(%{invalid_kye: "war"})
    bet = GameServer.get_bet()
    assert %{} == bet

    assert ["At least one bet is required."] == msg
  end

  test "try to create bet with invalid value" do
    GameServer.start_link()
    [msg] = GameServer.new_bet(%{"card-odd": "invalid"})
    bet = GameServer.get_bet()
    assert %{} == bet
    assert "Invalid card-odd. Allowed: [player croupier war]" == msg
  end

  test "shuffle deck of card" do
    GameServer.start_link()
    GameServer.new_bet(%{"card-odd": "war"})
    GameServer.shuffle_cards()
    assert 30 == GameServer.get_shuffled_times()
    GameServer.shuffle_cards()
    assert 60 == GameServer.get_shuffled_times()
  end

  test "shuffle deck of card before bet should return error" do
    GameServer.start_link()
    GameServer.shuffle_cards()
    assert 0 == GameServer.get_shuffled_times()
  end

  test "grab user card" do
    GameServer.start_link()
    GameServer.new_bet(%{"card-odd": "war"})
    GameServer.shuffle_cards()
    card = GameServer.grab_player_card()
    assert card.power in 1..11
  end

  test "grab before bet should return error" do
    GameServer.start_link()
    msg = GameServer.grab_player_card()
    assert msg == "Shuffle card before game"
  end

  test "grab croupier card before player should return error" do
    GameServer.start_link()
    GameServer.new_bet(%{"card-odd": "war"})
    GameServer.shuffle_cards()
    msg = GameServer.grab_croupier_card()
    assert msg == "Player grab card first"
  end

  test "grab croupier card after player should return croupier card" do
    GameServer.start_link()
    GameServer.new_bet(%{"card-odd": "war"})
    GameServer.shuffle_cards()
    GameServer.grab_player_card()
    card = GameServer.grab_croupier_card()
    assert card.power in 1..11
  end
end
