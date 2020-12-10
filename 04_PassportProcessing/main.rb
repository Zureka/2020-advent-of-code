require_relative "passport_parser"

file_as_string = ""

File.open("data.txt").each do |line|
  file_as_string << if line.strip.empty?
    "|"
  else
    line.strip
      .ljust(line.length + 1, " ")
      .gsub("  ", " ")
  end
end

passports = file_as_string.split("|")
valid_passport_strings = []

passports.each do |info|
  valid_passport_strings << info if PassportParser.passport_structure_valid?(info)
end

puts "\n--- Part 1 ---"
puts "Checking structure of passport strings..."
puts "Detected #{valid_passport_strings.length} valid passport strings."

puts "\n--- Part 2 ---"
puts "Checking validity of passport info..."

valid_passports = []

valid_passport_strings.each do |info|
  valid_passports << info if PassportParser.passport_info_valid?(info)
end

puts "Detected #{valid_passports.length} valid passports."
