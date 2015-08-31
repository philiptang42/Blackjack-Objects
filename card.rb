require 'pry'

class Card
  attr_accessor :value, :suit, :name
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def name
    "#{value}#{suit}"

  def face?
    ['J', 'Q', 'K'].include?(@value)
  end

  def ace?
    @value == "A"
  end
end
end
