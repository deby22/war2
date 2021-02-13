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

  @type picked_card_and_rest_of_deck :: %{card: %Cards.Card{}, deck: list(%Cards.Card{})}

  @spec create_card(String.t(), String.t()) :: %Cards.Card{}
  def create_card(suit, value) do
    Card.new(suit, value)
  end

  @spec create_deck(integer()) :: list(%Cards.Card{})
  def create_deck(ammount \\ 5) do
    for suit <- @suits, value <- @values, _ <- 1..ammount, do: Card.new(suit, value)
  end

  @spec shuffle(list(%Cards.Card{})) :: list(%Cards.Card{})
  def shuffle(cards) do
    IO.inspect("Shuffling deck of Card")
    Enum.shuffle(cards)
  end

  def shuffle(cards, times) when times <= 0, do: shuffle(cards)
  def shuffle(cards, times), do: shuffle(cards) |> shuffle(times - 1)

  @spec pick_one(list(%Cards.Card{})) :: picked_card_and_rest_of_deck
  def pick_one([picked | other_cards]), do: %{card: picked, deck: other_cards}
end
