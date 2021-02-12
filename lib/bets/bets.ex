defmodule Bets.Bets do
  alias Bets.Bet

  def create_bet(bet = %{}) do
    validated_bet = Bet.validate_bet(struct(Bet, bet))

    case Map.pop(validated_bet, :errors) do
      {nil, validated_bet} -> {:ok, validated_bet}
      {errors, _} -> {:errors, errors}
    end
  end

  # def summary(bet, player_card, croupier_card, card_odd) do
  #   %{
  #     "suit-player": bet."suit-player" == player_card.suit,
  #     "card-odd": bet."card-odd" == card_odd,
  #     "color-croupier": bet."color-croupier" == croupier_card.color,
  #     "color-player": bet."color-player" == player_card.color,
  #     "suit-croupier": bet."suit-player" == croupier_card.suit
  #   }
  # end
end
