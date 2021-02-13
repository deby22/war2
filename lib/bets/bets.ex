defmodule Bets.Bets do
  alias Bets.Bet

  @type invalid_bet_message :: {:errors, list(String.t())}
  @type validated_bet :: {:ok, %Bets.Bet{}}

  @spec create_bet(map()) :: validated_bet | invalid_bet_message
  def create_bet(bet = %{}) do
    validated_bet = Bet.validate_bet(struct(Bet, bet))

    case Map.pop(validated_bet, :errors) do
      {nil, validated_bet} -> {:ok, validated_bet}
      {errors, _} -> {:errors, errors}
    end
  end
end
