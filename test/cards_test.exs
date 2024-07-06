defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "greets the world" do
    assert Cards.hello() == :world
  end

  test "creates a deck of cards" do
    deck = Cards.create_deck()
    assert length(deck) == 52
    assert Cards.contains?(deck, "Ace of Hearts")
    assert Cards.contains?(deck, "King of Spades")
  end

  test "shuffles a deck of cards" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    refute deck == shuffled_deck
  end

  test "deals a hand of cards" do
    deck = Cards.create_deck()
    {hand, remaining} = Cards.deal(deck, 5)
    assert length(hand) == 5
    assert length(remaining) == 47
  end

  test "deals a hand of cards with a different hand size" do
    deck = Cards.create_deck()
    {hand, remaining} = Cards.deal(deck, 10)
    assert length(hand) == 10
    assert length(remaining) == 42
  end

  test "create a hand of cards" do
    deck = Cards.create_hand(5)
    assert length(deck) == 5
  end
end
