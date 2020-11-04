require_relative "PokeAPI"

class Pokemon
  attr_reader :moves

  attr_reader :first_type, :second_type, :current_level, :name, :current_xp, :total_xp_next_level

  attr_reader :current_max_hp, :current_attack, :current_defense,
  :current_special_attack, :current_special_defense, :current_speed

  attr_reader :base_hp, :base_attack, :base_defense,
  :base_special_attack, :base_special_defense, :base_speed, :base_xp

  def initialize(pokemon_index, initial_level)
    moves = []
    @current_level = initial_level
    @current_xp = get_level_total_xp(@current_level)
    @total_xp_to_next_level = get_level_total_xp(@current_level + 1)
    

    @result = PokeAPI.get_pokemon_info_by_number(pokemon_index)

    
    #other info
    @first_type = @result["types"][0]["type"]["name"].to_s
    if (@result["types"][1] != nil)
      @second_type = @result["types"][1]["type"]["name"]
    end
    @name = @result["name"]
    @base_xp = @result["base_experience"]

    #base stats
    @base_hp = @result["stats"][0]["base_stat"].to_i
    @base_attack = @result["stats"][1]["base_stat"].to_i
    @base_defense = @result["stats"][2]["base_stat"].to_i
    @base_special_attack = @result["stats"][3]["base_stat"].to_i
    @base_special_defense = @result["stats"][4]["base_stat"].to_i
    @base_speed = @result["stats"][5]["base_stat"].to_i
    
    change_stats_based_on_level()
  end

  def add_xp(xp_gain)
    if (xp_gain > 0 && @current_level<100)
      @current_xp += xp_gain
      while true
        if(@current_xp >= @total_xp_next_level)
          level_up()
          @total_xp_next_level = get_level_total_xp(@current_level + 1)
        else
          return
        end
      end
    end
  end

  def get_level_total_xp(level)
    @total_xp_next_level = (level-1)**3
  end

  def current_xp_to_next_level()
    return @total_xp_next_level - @current_xp
  end

  def level_up()
  
    puts "!LEVEL UP!"
    @current_level += 1
    change_stats_based_on_level()
  end

  def change_stats_based_on_level()
    @current_max_hp = (((2*@base_hp*@current_level)/100) + @current_level + 10).round
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