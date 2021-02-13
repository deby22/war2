defmodule War.GameManager do
  @moduledoc """
    Process of War Game
      User cannot start game before put bet
      Before grab, card must be shuffled
      Player grab card first
      Croupier could grab card after player
      After 3seconds of grabbing card by grabier user will see result
  """
  alias Bets.Bets
  alias War.{Summary, Game}

  def new_game(), do: {:ok, Game.new()}

  def create_bet(game, _) when map_size(game.bet) != 0,
    do: {:error, "You couldn't put another bet"}

  def create_bet(game, bet) do
    case Bets.create_bet(bet) do
      {:ok, bet} ->
        {:ok, Game.create_bet(game, bet)}

      {:errors, msg} ->
        {:error, msg}
    end
  end

  def shuffle_deck_of_card(game) when map_size(game.bet) == 0,
    do: {:error, "Put bet before shuffling cards"}

  def shuffle_deck_of_card(game), do: {:ok, Game.shuffle_deck_of_card(game)}

  def grab_player_card(game) when game.shuffled_times == 0 do
    {:error, "Shuffle card before game"}
  end

  def grab_player_card(game) when game."player-card" != nil do
    {:error, "You can't grab another Card. Its croupier turn."}
  end

  def grab_player_card(game), do: {:ok, Game.grab_player_card(game)}

  def game_summary(game) do
    {:ok, Summary.summary(game)}
  end

  def grab_croupier_card(game) when game."player-card" == nil do
    {:error, "Player grab card first"}
  end

  def grab_croupier_card(game) when game."croupier-card" != nil do
    {:error, "Croupier can't grab another Card. Wait for result."}
  end

  def grab_croupier_card(game), do: {:ok, Game.grab_croupier_card(game)}
end
