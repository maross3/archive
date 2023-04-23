# frozen_string_literal: true

class NumberGuesser

  attr_reader :playing

  def initialize(range)
    @range = range
    @guesses = 0
    @max_guesses = Math.log2(range.size).to_i + 1
    @answer = range.to_a.sample
    @playing = true
  end

  def guess(number)

    @guesses += 1
    if @guesses > @max_guesses
      puts "You are out of guesses."
      game_over
    end
    if number > @answer
      puts "Your guess is too high. You have #{max_guesses - guesses} guesses remaining."
    elsif number < @answer
      puts "Your guess is too low. You have #{max_guesses - guesses} guesses remaining."
    elsif number == @answer
      puts "That's the number! You won in #{guesses} guesses!"
    else
      puts "Invalid guess. You have #{max_guesses - guesses} guesses remaining."
    end
  end

  def playing
    @playing
  end

  def game_over
    puts "Would you like to play again? (y/n)"
    answer = gets.chomp
    if answer == 'y'
      @guesses = 0
      @answer = @range.to_a.sample
    else
      puts "Thanks for playing!"
      exit
    end
  end

  private

  attr_accessor :guesses, :range, :max_guesses, :answer
end

guesser = NumberGuesser.new(1..100)

while guesser.playing
  puts "Enter a number between 1 and 100:"
  guess = gets.chomp.to_i
  guesser.guess(guess)
end