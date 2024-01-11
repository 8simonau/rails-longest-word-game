require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) {|index| ("A".."Z").to_a.sample}
    @total_score = session[:total_score] || 0
  end

  def score
    @word = params[:word]
    @letters = params[:letters].chars
    # check if word is english
    @english = english?(@word)
    # check if word letters are enough in the grid
    @enough_in_grid = enough_in_grid?(@word.chars, @letters)
    if @english && @enough_in_grid
      session[:total_score] += @word.length
    end
    @total_score = session[:total_score] || 0
  end

  private

  def english?(word)
    uri = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = JSON.parse(URI.open(uri).read)
    return response["found"]
  end

  def enough_in_grid?(word_array, grid)
    # select letters in word_array for which count in word_array is greater than count in grid
    selected_letters = word_array.select {|letter| word_array.count(letter.upcase) > grid.count(letter)}
    # return true if no letters are selected
    return selected_letters.empty?
  end

end
