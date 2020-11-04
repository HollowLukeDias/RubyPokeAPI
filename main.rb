require_relative "Pokemon"
require_relative "Player"

def welcome
  system("cls")
  puts "*****************************************************************************************"
  puts "Welcome to my PokeAPI implementation"
  puts "For now you can only choose an initial Pokémon and tranfer it between party and computer"
  puts "But later you might be able to put them to fight random pokémon, and then maybe trainers"
  puts "Perhaps pokemon evolution? Who knows"
  puts "*****************************************************************************************"
  puts
end

def create_a_character()
  puts "Please, choose your character name:"
  player_name = gets
  player = Player.new(player_name)
end

def choose_inital_pokemon(player)
  puts "Chosse your initial Pokémon:"
  puts "1 - Bulbasaur"
  puts "2 - Charmander"
  puts "3 - Squirtle"
  while true
    player_choice = gets.to_s
    case player_choice.strip
    when "1"
      player.add_pokemon_to_party(Pokemon.new(1))
      return
    when "2"
      player.add_pokemon_to_party(Pokemon.new(4))
      return
    when "3"
      player.add_pokemon_to_party(Pokemon.new(7))
      return
    when "0"
      return
    else
      puts "Please, choose one of the Inital Pokémon"
    end
  end
end

welcome()
player = create_a_character()
puts player
puts "Your name is #{player::player_name}"
choose_inital_pokemon(player)
player.print_party_pokemon