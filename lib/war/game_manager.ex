defmodule War.GameManager do
  @doc """
  Allowed states
    new game
    game with bet
    shuffled card
    grabbed player card
    grabbed croupier card

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

  def grab_croupier_card(game), do: {:ok, Game.grab_croupier_card(game)}
end
