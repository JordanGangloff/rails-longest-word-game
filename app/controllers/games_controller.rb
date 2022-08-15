# controller for the game
class GamesController < ApplicationController
  require 'open-uri'

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:guess]
    @letters = params[:grid]
    @include = checking_word_grid?(@word, @letters)
    @english = checking_word_english?(@word)
  end

  private

  def checking_word_english?(word)
    url = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    words = JSON.parse(url.read)
    words['found']
  end

  def checking_word_grid?(word, grid)
    letters = word.upcase.chars
    letters.all? { |letter| letters.count(letter) <= grid.count(letter) }
  end
end
