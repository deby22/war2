defmodule Bets.Bets do
  alias Bets.Bet

  def create_bet(bet = %{}) do
    validated_bet = Bet.validate_bet(struct(Bet, bet))

    case Map.pop(validated_bet, :errors) do
      {nil, validated_bet} -> {:ok, validated_bet}
      {errors, _} -> {:errors, errors}
    end
  end
end
