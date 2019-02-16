class HangpersonGame
    
    # add the necessary class methods, attributes, etc. here
    # to make the tests in spec/hangperson_game_spec.rb pass.
    attr_accessor :word, :wrong_guesses, :guesses
    # Get a word from remote "random word" service
    
    # def initialize()
    # end
    
    def initialize(word)
        @word = word
        @wrong_guesses = ""
        @guesses = ""
    end
    
    def guess(letter)
        invalid(letter)
        letter.downcase!
        
        if(!repeatedLetter(letter))
            if (@word.include?(letter))
                @guesses.concat(letter)
                else
                @wrong_guesses.concat(letter)
            end
            else
            return false
        end
    end
    
    def repeatedLetter (letter)
        ((@guesses.include?letter) || (wrong_guesses.include?letter))
    end
    
    
    def invalid (letter)
        raise ArgumentError, '' if letter == nil || letter.empty? || /[^a-zA-Z]/.match(letter)
    end
    
    def word_with_guesses
        displayed_word = '-' * @word.size
        counter = 0
        @word.each_char do |char|
            if @guesses.include?char
                displayed_word[counter] = char
            end
            counter += 1
        end
        displayed_word
    end
    
    def check_win_or_lose
        if (word_with_guesses == @word)
            :win
            elsif(@wrong_guesses.size>=7)
            :lose
            else
            :play
        end
    end
    # You can test it by running $ bundle exec irb -I. -r app.rb
    # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
    #  => "cooking"   <-- some random word
    def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
    return http.post(uri, "").body
    }
end

end
