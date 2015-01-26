#Lesson 2 Assignment: OOP Blackjack

class Player

  attr_accessor :hand, :player_hand, :total, :deck
  
  def initialize(name)
    @name = name
    @deck = Deck.new.create_deck
    @hand = []
    @total = 0
  end

  def initial_dealing
    @hand = []
    @hand<<@deck.pop
    @hand<<@deck.pop
    @hand
  end

  def calculate_hand(hand)
    formatted_hand = hand.map {|e| e[0]}
    num_aces = formatted_hand.count("Ace")
    @total = 0
    formatted_hand.each do |e|
      if e == "Ace"
    	@total += 11
      elsif e == "Jester"
    	@total += 10
      elsif e == "Queen"
    	@total += 10
      elsif e == "King"
    	@total += 10
      else
    	@total += e.to_i
      end
    end
    num_aces.times do
      @total -= 10 if total > 21
    end
    @total
  end
end

class John<Player

  def player_hand
    puts "#{@name} has drawn: "
    puts @hand
    display_total
  end

  def display_total
    calculate_hand(@hand)
    puts "#{@name} has a total of: #{@total}"
    hit_or_stay?
  end
  
  def hit_or_stay?
    puts ""
    while @total < 21
      puts "Would you like to hit, or stay? Type and enter h to hit, or s to stay: "
      bet = gets.chomp.downcase
      system "clear"
      if bet == "h"
      	@hand<<deck.pop
      	puts "You have drawn: "
      	puts @hand[-1]
      	display_total
      elsif bet == "s"
      	puts "You have chosen to stay."
      	break
      else
      	hit_or_stay?
      end
    end
    @total
  end
end

class Dealer<Player
  
  def display_one_dealer_card
    puts "The dealer's face up card is: "
    puts @hand[0]
    puts ""
  end

  def dealer_hit_or_stay
    calculate_hand(@hand)
    puts ""
    while @total.to_i < 17 do
      puts "Dealer has chosen to hit"
      @hand<<@deck.pop
      calculate_hand(@hand)
    end
    @total
  end
end

class Deck

  attr_accessor :deck
  
  def initialize
    @face_value = ["2","3","4","5","6","7","8","9","10","Jester","Queen","King","Ace"]
    @suit = ["of Clubs", "of Hearts", "of Diamonds", "of Spades"]
    @deck = @face_value.product(@suit).shuffle!
    deck.shuffle!
  end
end

class Game

  def initialize
  @deck = Deck.new
  @john = John.new("Barney")
  @dealer = Dealer.new("Dealer Joe")
  @outcome = DetermineWinner.new(@player_total, @dealer_total)
end

  def intro
    puts ""
    puts "---Welcome to Blackjack!!!---"
    puts ""
  end

  def new_game?
    puts ""
    puts "Would you like to play again? Please type and enter y for yes, or n for no: "
    restart = gets.chomp.downcase
    puts ""
    if restart == "y"
      system "clear"
      play
    elsif restart == "n"
      puts "Thanks for playing!"
      exit
    else
      new_game?
    end
  end

  def play
    intro
    @deck.create_deck
    @dealer.initial_dealing
    @dealer.display_one_dealer_card
    @john.initial_dealing
    @john.player_hand
    @dealer.dealer_hit_or_stay
    #@john.display_total
    new_game?
  end
end

Game.new.play
