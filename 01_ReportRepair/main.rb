numbers = []
p1_match = []
p2_match = []

File.open("data.txt").each do |line|
  numbers << line.to_i
end

puts "\n--- Part 1 ---"

numbers.each do |num1|
  numbers.each do |num2|
    # Find 2 numbers in list that sum to 2020
    p1_match << {a: num1, b: num2} if num1 + num2 == 2020
  end
end

puts "Found 2 numbers that sum to 2020"
puts "#{p1_match[0][:a]} + #{p1_match[0][:b]} = 2020"

puts "Their product is:"
puts "#{p1_match[0][:a]} * #{p1_match[0][:b]} = #{p1_match[0][:a] * p1_match[0][:b]}"

puts "\n--- Part 2 ---"

numbers.each do |num1|
  numbers.each do |num2|
    numbers.each do |num3|
      # Find 2 numbers in list that sum to 2020
      p2_match << {a: num1, b: num2, c: num3} if num1 + num2 + num3 == 2020
    end
  end
end

puts "Found 3 numbers that sum to 2020"
puts "#{p2_match[0][:a]} + #{p2_match[0][:b]} + #{p2_match[0][:c]}= 2020"

puts "Their product is:"
puts "#{p2_match[0][:a]} * #{p2_match[0][:b]} * #{p2_match[0][:c]} = #{p2_match[0][:a] * p2_match[0][:b] * p2_match[0][:c]}\n"
