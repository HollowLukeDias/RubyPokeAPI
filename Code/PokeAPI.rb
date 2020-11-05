require 'rest-client'
require 'json'

class PokeAPI
  def self.get_pokemon_info_by_number(number)
    begin
      response = RestClient::Request.new(
        :method => :get,
        :url =>  'https://pokeapi.co/api/v2/pokemon/' + number.to_s.strip + '/',
      ).execute
      results = JSON.parse(response)
      return results
    rescue => exception
      puts "ERROR!"
      puts exception
      gets
    end
  end
end