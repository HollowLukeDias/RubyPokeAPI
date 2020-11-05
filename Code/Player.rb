require_relative 'Pokemon'

class Player
  attr_reader :player_name
  attr_reader :party_pokemon, :computer_pokemon
  attr_reader :party_size
  $party_limit = 6
  

  def initialize(name)
    @player_name = name
    @computer_pokemon = []
    @party_pokemon = []
    @party_size = 0
  end

  def add_pokemon_computer(pokemon)
    @computer_pokemon << pokemon
  end

  def transfer_party_to_computer(pokemon)
    @party_pokemon.delete(pokemon)
    @computer_pokemon << pokemon
    @party_size -= 1
  end

  def transfer_computer_to_party(pokemon)
    if (@party_size < $party_limit)
      @computer_pokemon.delete(pokemon)
      @party_pokemon << pokemon
      @party_size += 1
    else
      puts "You can't add more Pokémon into your party"
    end
  end

  def add_pokemon_to_party(pokemon)
    if (@party_size < $party_limit)
      @party_pokemon << pokemon
      @party_size += 1
    else
      puts "You can't add more Pokémon into your party"
    end
  end

  def release_pokemon(pokemon)
    @an_array.delete(pokemon)
  end

  def print_party_pokemon
    @party_pokemon.each do |pokemon|
      text = "Pokémon name: #{pokemon.name.capitalize} - XP to next level: #{pokemon.current_xp_to_next_level()} - Level: #{pokemon.current_level}"
      puts text
    end
  end

end