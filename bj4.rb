require 'pry'

puts " \n\n <<<<Welcome to Computer Blackjack>>>\n\n"
 
# def build_deck
cards = [ 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
suits = ["Diamonds", "Spades", "Clubs", "Hearts"]
deck = []
cards.each do |card|
  suits.each do |suit|
    deck << [card, suit]
  end
end
deck

# def deal_hands(deck)
deck.shuffle!
player_cards = []
dealer_cards = []
2.times do
  player_cards << deck.pop
  dealer_cards << deck.pop
end

def score(cards)
  arr = cards.map{ |e| e[0] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11 
    elsif value.to_i == 0
      total += 10
    else 
      total += value
    end
  end

  #correct for Aces
  arr.select{|e| e == "A"}.count.times do
    total > 21 ? total -= 10 : break
  end
  total
end

player_score = score(player_cards)
dealer_score = score(dealer_cards)

def print_bust(name, score)
  puts "#{name} has gone bust this round with a card total of #{score}!"
  exit
end

def print_winner(name, score)
  puts "#{name} has won this round with a card total of #{score}!"
  exit
end

def print_tie(name, score)
  puts "#{name} and dealer have tied this round with a card total of #{score} each!"
  exit
end

#Start Game
begin
  puts "Would you like to play - Y/N?"
  answer = gets.chomp.downcase
  exit if answer == "n"
end until answer == "y"

puts  "What is your first name?"
first_name = gets.chomp.capitalize
puts "#{first_name}, you've been dealt two cards: #{player_cards[0]} and #{player_cards[1]}."
puts "The dealer has been dealt two cards:  #{dealer_cards[0]} and #{dealer_cards[1]}. "
puts "#{first_name}, you have a total of #{player_score} and the dealer has a total of #{dealer_score}."

#Player turn
if player_score == 21
  print_winner(first_name, player_score)
  exit
end

if dealer_score == 21
  first_name = "Dealer"
  print_winner(first_name, dealer_score)
  exit
end
  
puts ""

while player_score < 21 
  puts "Would you like to [H]it or [S]tay?"
  hit_stay = gets.chomp.downcase
  if hit_stay == "s"
    break
  end

  if hit_stay != "h"
    puts "Input must be either 'H' or 'S'"
    next
  end

  hit_card = deck.pop
  player_cards << hit_card
  player_score = score(player_cards)
  puts "#{first_name}, you've been dealt a new card: #{player_cards.last} for a new total of #{player_score}."
  puts ""
  if player_score == 21
    print_winner(first_name, player_score)
    exit  
  elsif player_score > 21
    print_bust(first_name, player_score)
    exit
  end
end

#Dealer turn
while dealer_score < 17
  hit_card = deck.pop
  dealer_cards << hit_card
  dealer_score = score(dealer_cards)
  puts "The dealer has been dealt a new card #{hit_card}."
 
  if dealer_score == 21
    first_name = "Dealer"
    print_winner(first_name, dealer_score)
  end

  if dealer_score > 21
    first_name = "Dealer"  
    print_bust(first_name, dealer_score)
    exit
  end
end

puts "You have a total of #{player_score}. Dealer has a total of #{dealer_score}."
puts ""

if player_score == dealer_score
  print_tie(first_name, player_score)
elsif player_score > dealer_score
  print_winner(first_name, player_score)
else
  first_name = "Dealer"
  print_winner(first_name, dealer_score)
end
