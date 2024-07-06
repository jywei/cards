defmodule Cards do
  @moduledoc """
    Provides methods for creating and manipulating a deck of cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
    Returns a list of strings representing a deck of cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    # A list of lists
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    # List.flatten(cards)

    # comprehension
    for suit <- suits, value <- values, do: "#{value} of #{suit}"
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  # Returns a tuple with the first element being the hand and the second element being the remaining deck
  # def deal(deck, hand_size) do
  #   Enum.split(deck, hand_size)
  # end

  @doc """
    Returns a tuple with the first element being the hand and the second element being the remaining deck.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, remaining} = Cards.deal(deck, 5)
      iex> hand
      ["Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts", "Five of Hearts"]
      iex> remaining
      ["Six of Hearts", "Seven of Hearts", "Eight of Hearts", "Nine of Hearts", "Ten of Hearts", "Jack of Hearts", "Queen of Hearts", "King of Hearts", "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds", "Six of Diamonds", "Seven of Diamonds", "Eight of Diamonds", "Nine of Diamonds", "Ten of Diamonds", "Jack of Diamonds", "Queen of Diamonds", "King of Diamonds", "Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs", "Five of Clubs", "Six of Clubs", "Seven of Clubs", "Eight of Clubs", "Nine of Clubs", "Ten of Clubs", "Jack of Clubs", "Queen of Clubs", "King of Clubs", "Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades", "Six of Spades", "Seven of Spades", "Eight of Spades", "Nine of Spades", "Ten of Spades", "Jack of Spades", "Queen of Spades", "King of Spades"]
  """
  def deal(deck, n) do
    {hand, remaining} = Enum.split(deck, n)
    {hand, remaining}
  end

  def save(deck, file) do
    # File.write!(file, deck)

    binary = :erlang.term_to_binary(deck)
    File.write(file, binary)
  end

  def load(file) do
    {status, binary} = File.read(file)

    case status do
      :ok -> :erlang.binary_to_term(binary)
      _ -> {:error, "File not found"}
    end
  end

  def old_load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> {:error, "File not found"}
    end
  end

  def old_create_hand_with_module_name(handsize) do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    Cards.deal(shuffled_deck, handsize)
  end

  # Not using pipe operator
  def old_create_hand(handsize) do
    deck = create_deck()
    shuffled_deck = shuffle(deck)
    deal(shuffled_deck, handsize)
  end

  # Using pipe operator
  def create_hand(handsize) do
    # Cards.create_deck
    # |> Cards.shuffle
    # |> Cards.deal(handsize)

    create_deck()
    |> shuffle()
    |> deal(handsize)
  end
end
