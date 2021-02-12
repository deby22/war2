defmodule Bets.Bet do
  alias Bets.BetValidator

  defstruct ~w"suit-player card-odd color-croupier color-player suit-croupier"a

  @allowed_suits ~w"heart diamond club spade"
  @allowed_colors ~w"black red"
  @allowed_odd ~w"player croupier war"

  def validate_bet(bet = %__MODULE__{}) do
    bet
    |> BetValidator.validate_at_least_one_value()
    |> BetValidator.validate_field(:"suit-player", @allowed_suits)
    |> BetValidator.validate_field(:"suit-croupier", @allowed_suits)
    |> BetValidator.validate_field(:"color-player", @allowed_colors)
    |> BetValidator.validate_field(:"color-croupier", @allowed_colors)
    |> BetValidator.validate_field(:"card-odd", @allowed_odd)
  end
end