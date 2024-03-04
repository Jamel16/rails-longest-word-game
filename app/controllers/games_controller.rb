require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(20).join(" ")
  end

  def score
    @letters = params[:lettres]
    @word = params[:input]

    unless @word.include?(@letters)
      @results = "Sorry but #{@word} can't be built of #{@letters}"
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(url).read
    words = JSON.parse(word_serialized)

    if words["found"] == true
      @results = "Congratulations! #{@word} is a valid English word!"
    else
      @results = "Sorry, but #{@word} does not seem to be a valid English word..."
    end
  end
end
