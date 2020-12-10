require "set"
require "pry"

puts "\n--- Part 1 ---"

file_as_string = ""
answer_sets = []

File.open("data.txt").each do |line|
  file_as_string << if line.strip.empty?
    "|"
  else
    line.strip
      .ljust(line.length + 1, " ")
      .delete(" ")
  end
end

file_as_string.split("|").each do |responses|
  answer_sets << responses.split("").to_set
end

sum_of_answers = answer_sets.reduce(0) { |sum, set| sum + set.length }
puts "There were a total of #{sum_of_answers} questions to which anyone in the group answered \"yes\"."

puts "\n--- Part 2 ---"

file_as_string = ""
File.open("data.txt").each do |line|
  file_as_string << if line.strip.empty?
    "|"
  else
    line.strip
      .ljust(line.length + 1, " ")
  end
end

all_answered_yes_count = file_as_string.split("|").reduce(0) { |sum, resp_str|
  responses = resp_str.split(" ")
  all_answered_yes = responses.map { |resp| resp.split("") }.inject(:&)
  sum + all_answered_yes.length
}

puts "There were a total of #{all_answered_yes_count} questions where everyone in the group answered \"yes\"."
