defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
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
end
