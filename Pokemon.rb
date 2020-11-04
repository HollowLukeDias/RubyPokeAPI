require_relative "PokeAPI"

class Pokemon

  attr_reader :first_type, :second_type, :current_level, :name

  attr_reader :current_hp, :current_attack, :current_defense,
  :current_special_attack, :current_special_defense, :current_speed

  attr_reader :base_hp, :base_attack, :base_defense,
  :base_special_attack, :base_special_defense, :base_speed

  def initialize(pokemon_number)
    @current_level = 5
    @result = PokeAPI.get_pokemon_info_by_number(pokemon_number)
    @first_type = @result["types"][0]["type"]["name"].to_s
    if (@result["types"][1] != nil)
      @second_type = @result["types"][1]["type"]["name"]
    end
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