#!/usr/bin/env ruby

# YOUR CODE HERE
require_relative "card"
require_relative "deck"
require_relative "hand"
require "pry"

class Blackjack
  attr_reader :deck, :player_hand, :dealer_hand
  def initialize
    @deck = Deck.new
    @dealer_hand = Hand.new
    @player_hand = Hand.new
    start_game
  end

  def start_game
    puts "The House always wins. Prepare to get wrecked.\n\n"
    player_turn
    dealer_turn unless @player_hand.score > 21
    puts result
  end

  def player_turn
    2.times { deal_to("Player") }
    puts "Player Score is #{@player_hand.score}"

    player_choice = nil
    until player_choice == 'S' || player_hand.score > 21
      player_choice = nil
      until valid_input?(player_choice)
        print "HIT OR STAND DAMNIT? (Enter H or S): "
        player_choice= gets.chomp.upcase
        puts
      end

      deal_to("Player") if player_choice == "H"
      puts "Player score is #{@player_hand.score}\n\n"
    end
  end

  def deal_to(user)
    dealt_card = @deck.draw!
    if user == 'Player'
      @player_hand.add(dealt_card)
    elsif user == 'Dealer'
      @dealer_hand.add(dealt_card)
    end

    puts "#{user} was dealt #{dealt_card.value} of #{dealt_card.suit}\n\n"
  end

  def valid_input?(input)
    ['H', 'S'].include?(input)
  end

  def dealer_turn
    2.times { deal_to("Dealer") }
    puts "Dealer Score is #{@dealer_hand.score}\n\n"

    until @dealer_hand.score >= 17
      deal_to("Dealer")
      puts "Dealer Score is #{@dealer_hand.score}\n\n"
    end
  end

  def result
    if @player_hand.score > 21
      "Player: #{player_hand.score} Dealer: #{dealer_hand.score} | Your hand went over 21 and busted. Now you die."
    elsif @dealer_hand.score > 21
      "Player: #{player_hand.score} Dealer: #{dealer_hand.score} | The House busted. You win but you won't leave here alive."
    elsif @player_hand.score > @dealer_hand.score
      "Player: #{player_hand.score} Dealer: #{dealer_hand.score} | Your hand beat the House. You win but you won't leave alive."
    elsif @player_hand.score < @dealer_hand.score
      "Player: #{player_hand.score} Dealer: #{dealer_hand.score} | Your hand is less than the House. You lose, sucker."
    else
      "Player: #{player_hand.score} Dealer: #{dealer_hand.score} | A tie? Impossible..."
    end
  end
end

game = Blackjack.new
