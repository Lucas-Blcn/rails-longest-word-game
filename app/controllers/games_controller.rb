require "open-uri"

class GamesController < ApplicationController

  def home
  end

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @score = params[:mon_mot]
    @fetch_word = fetch_data
    @exist = ''
    if @fetch_word && mot_creatable?(params[:letters], @score)
      @exist = "Congratulations!🤩 #{@score} is a valid English word."
    elsif @fetch_word && !mot_creatable?(params[:letters], @score)
      @exist = "Sorry but #{@score} can't be built with #{params[:letters]}🤨"
    else
      @exist = "Sorry but #{@score} does not seem to be a valid English word🤥"
    end
  end

  def fetch_data()
    # Construct the URL for the API endpoint with the word parameter
    api_url = "https://wagon-dictionary.herokuapp.com/#{@score}"
    response = URI.open(api_url)
    # Parse the JSON response
    @data = JSON.parse(response.read)["found"]
  end

  def mot_creatable?(lettres_aleatoires, mot_utilisateur)
    @characters = mot_utilisateur.chars
    @characters.all? { |lettre| lettres_aleatoires.include?(lettre) }
  end
end

# puts fetch_data("banana")
