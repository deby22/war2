defmodule War.GameManager do
  @moduledoc """
    Process of War Game
      User cannot start game before put bet
      Before grab, card must be shuffled
      Player grab card first
      Croupier could grab card after player
      After 3seconds of grabbing card by grabier user will see result
  """
  alias Bets.{Bet, Bets}
  alias War.{Summary, Game}

  @type created_game :: {:ok, %War.Game{cards: list(%Cards.Card{})}}
  @type game_with_player_card ::
          {:ok, %War.Game{"player-card": %Cards.Card{}, cards: list(%Cards.Card{})}}
  @type game_with_player_and_croupier_card ::
          {:ok,
           %War.Game{
             "croupier-card": %Cards.Card{},
             "player-card": %Cards.Card{},
             cards: list(%Cards.Card{})
           }}
  @type invalid_game_message :: {:error, String.t()}
  @type game_with_bet :: {:ok, %War.Game{bet: %Bet{}}}

  @spec new_game() :: created_game
  def new_game(), do: {:ok, Game.new()}

  @spec create_bet(%War.Game{}, any()) :: invalid_game_message | game_with_bet
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

  @spec shuffle_deck_of_card(%War.Game{}) :: created_game | invalid_game_message
  def shuffle_deck_of_card(game) when map_size(game.bet) == 0,
    do: {:error, "Put bet before shuffling cards"}

  def shuffle_deck_of_card(game), do: {:ok, Game.shuffle_deck_of_card(game)}

  @spec grab_player_card(%War.Game{}) :: game_with_player_card | invalid_game_message
  def grab_player_card(game) when game.shuffled_times == 0 do
    {:error, "Shuffle card before game"}
  end

  def grab_player_card(game) when game."player-card" != nil do
    {:error, "You can't grab another Card. Its croupier turn."}
  end

  def grab_player_card(game), do: {:ok, Game.grab_player_card(game)}

  @spec game_summary(%War.Game{}) :: {:ok, %War.Summary{}} | invalid_game_message
  def game_summary(game) when game."card-odd" == nil do
    {:error, "You can't get summary before play"}
  end

  def game_summary(game) do
    {:ok, Summary.summary(game)}
  end

  @spec grab_croupier_card(%War.Game{}) ::
          game_with_player_and_croupier_card | invalid_game_message
  def grab_croupier_card(game) when game."player-card" == nil do
    {:error, "Player grab card first"}
  end

  def grab_croupier_card(game) when game."croupier-card" != nil do
    {:error, "Croupier can't grab another Card. Wait for result."}
  end

  def grab_croupier_card(game) do
    {:ok, Game.grab_croupier_card(game) |> Game.play_round()}
  end
end
