require 'rest-client'
require 'json'

def get_pokemon_info_by_number(number)
  begin
    response = RestClient::Request.new(
      :method => :get,
      :url =>  'https://pokeapi.co/api/v2/pokemon/' + number.to_s + '/',
    ).execute
    results = JSON.parse(response)
    return results
  rescue => exception
    puts "ERROR!"
    puts exception
    gets
  end
end

class Pokemon

  attr_accessor :current_hp, :current_attack, :current_defense,
  :current_special_attack, :current_special_defense, :current_speed

  attr_reader :current_level, :name, :base_hp, :base_attack, :base_defense,
  :base_special_attack, :base_special_defense, :base_speed

  def initialize(pokemon_number)
    @current_level = 4
    @result = get_pokemon_info_by_number(pokemon_number)
    @name = @result["name"]
    @base_hp = @result["stats"][0]["base_stat"].to_i
    @base_attack = @result["stats"][1]["base_stat"].to_i
    @base_defense = @result["stats"][2]["base_stat"].to_i
    @base_special_attack = @result["stats"][3]["base_stat"].to_i
    @base_special_defense = @result["stats"][4]["base_stat"].to_i
    @base_speed = @result["stats"][5]["base_stat"].to_i

    change_stats_based_on_level()
  end

  def level_up()
    @current_level += 1
    change_stats_based_on_level()
  end

  def change_stats_based_on_level()
    @current_hp = (((2*@base_hp*@current_level)/100) + @current_level + 10).round
    @current_attack = calculate_new_skill(@base_attack)
    @current_defense = calculate_new_skill(@base_defense)
    @current_special_attack = calculate_new_skill(@base_special_attack)
    @current_special_defense = calculate_new_skill(@base_special_defense)
    @current_speed = calculate_new_skill(@base_speed)

  end

  def calculate_new_skill(base_value)
    return (((2*base_value*@current_level)/100)+5).round
  end

end

puts "choose your pokemon index"
number = gets.to_s.strip
some_pokemon = Pokemon.new(number)
puts "You chose: " + some_pokemon.name.capitalize()
puts"HP: " +  some_pokemon.current_hp.to_s
puts
for i in 0..5
  puts "level up!!"
  puts "current level: #{some_pokemon.current_level}"
  some_pokemon.level_up()
  puts "HP: " + some_pokemon.current_hp.to_s
  puts
end