defmodule Bets.BetValidator do
  @moduledoc false

  @spec valid?(%Bets.Bet{}) :: boolean
  def valid?(fields) do
    fields
    |> Map.get(:errors, [])
    |> Enum.empty?()
  end

  @spec validate_field(%Bets.Bet{}, atom, list(String.t())) :: map()
  def validate_field(fields, field, allowed_choices) do
    value = Map.get(fields, field)

    if value == nil or value in allowed_choices do
      fields
    else
      allowed = Enum.join(allowed_choices, " ")
      add_error(fields, "Invalid #{field}. Allowed: [#{allowed}]")
    end
  end

  @spec validate_at_least_one_value(%Bets.Bet{}) :: map()
  def validate_at_least_one_value(fields) do
    if at_least_one_value?(fields) do
      fields
    else
      add_error(fields, "At least one bet is required.")
    end
  end

  @spec at_least_one_value?(%Bets.Bet{}) :: boolean
  defp at_least_one_value?(fields) do
    fields
    |> Map.from_struct()
    |> Map.values()
    |> Enum.filter(& &1)
    |> Enum.any?()
  end

  @spec add_error(%Bets.Bet{}, String.t()) :: %{errors: list()}
  defp add_error(fields, error_message) do
    if Map.has_key?(fields, :errors) do
      Map.update(fields, :errors, [], &[error_message | &1])
    else
      Map.put(fields, :errors, [error_message])
    end
  end
end
