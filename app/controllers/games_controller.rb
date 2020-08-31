require 'open-uri'

class GamesController < ApplicationController
    def new
        @letters = (0...10).map{65.+(rand(25)).chr}
    end

    def score
       @word = params[:word]
       @upcase_word = @word.upcase.chars
       @letters = params[:letters].split

       @result = word_is_in_letters?(@upcase_word, @letters)
       @valid_word = valid_word?(@word)
       
       @score = 0
       
       if @result == true &&  @valid_word == true
        @score +=1
        @message = "Ok! you are smarter than a chimp and your score is #{@score}!"
        
       else
        @message = "You fool! You are an idiot!"
       end
    end

    def valid_word?(word)
        url = "https://wagon-dictionary.herokuapp.com/#{word}"
        user_serialized = open(url).read
        user = JSON.parse(user_serialized)
        user["found"]
    end
end


def word_is_in_letters?(word, letters)
    return false if word.empty?
    word.all? { |letter| word.count(letter) <= letters.count(letter) }

  
  end
  