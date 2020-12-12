require 'pry'

class JoltageHelpers

  def initialize(adapters) 
    @find_paths = {}
    @adapters = adapters
  end

  def count_adapter_paths()
    find_paths_with_cache(@adapters.min, @adapters.max)
  end

  private

  def find_paths(current_joltage, final_joltage)
    contains_one = @adapters.include?(current_joltage + 1)
    contains_two = @adapters.include?(current_joltage + 2)
    contains_three = @adapters.include?(current_joltage + 3)

    if current_joltage == final_joltage
      puts "Found a path!"
      1
    elsif !contains_one and !contains_two and !contains_three
      0
    else
      count = 0 

      if contains_one 
        count += find_paths_with_cache(current_joltage + 1, final_joltage)
      end

      if contains_two 
        count += find_paths_with_cache(current_joltage + 2, final_joltage)
      end

      if contains_three 
        count += result = find_paths_with_cache(current_joltage + 3, final_joltage)
      end

      count
    end
  end

  def find_paths_with_cache(current_joltage, final_joltage)
    @find_paths["#{current_joltage}-#{final_joltage}"] ||= find_paths(current_joltage, final_joltage)
  end
end
