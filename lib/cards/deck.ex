defmodule Cards.Deck do
  @moduledoc """
    Processing deck of card
      Create new deck of card build as 5 basic deck of card
      Shuffling deck of card
      pick one card from the top
  """

  alias Cards.Card

  @values ~w[2 3 4 5 6 7 8 9 10 J Q K A]
  @suits ~w[club heart spade diamond]
  def create_card(suit, value) do
    Card.new(suit, value)
  end

  def create_deck(ammount \\ 5) do
    for suit <- @suits, value <- @values, _ <- 1..ammount, do: Card.new(suit, value)
  end

  def shuffle(cards) do
    IO.inspect("Shuffling deck of Card")
    Enum.shuffle(cards)
  end

  def shuffle(cards, times) when times <= 0, do: shuffle(cards)
  def shuffle(cards, times), do: shuffle(cards) |> shuffle(times - 1)

  def pick_one([picked | other_cards]), do: %{card: picked, deck: other_cards}
end
