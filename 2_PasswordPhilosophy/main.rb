password_checks = []

File.open("data.txt").each do |line|
  parts = line.split(":").map { |p| p.strip }
  policy_parts = parts[0].split(" ")
  range = policy_parts[0].split("-")
  policy = {
    min: range[0].to_i,
    max: range[1].to_i,
    letter: policy_parts[1]
  }
  password_checks << {
    policy: policy,
    password: parts[1]
  }
end

total_passwords = password_checks.length

puts "\n--- Part 1 ---"
p1_invalid_passwords = []

password_checks.each do |check|
  pw = check[:password]
  min = check[:policy][:min]
  max = check[:policy][:max]
  letter_count = pw.count(check[:policy][:letter])

  p1_invalid_passwords << pw if letter_count < min || letter_count > max
end

num_invalid = p1_invalid_passwords.length
num_valid = total_passwords - num_invalid

puts "Detected #{num_invalid} invalid passwords out of #{total_passwords}."
puts "There are #{num_valid} valid passwords."

puts "\n--- Part 2 ---"
p2_invalid_passwords = []

password_checks.each do |check|
  pw = check[:password]
  char = check[:policy][:letter]
  p1 = check[:policy][:min] - 1
  p2 = check[:policy][:max] - 1

  p2_invalid_passwords << pw if (pw[p1] == char && pw[p2] == char) || (pw[p1] != char && pw[p2] != char)
end

num_invalid = p2_invalid_passwords.length
num_valid = total_passwords - num_invalid

puts "Detected #{num_invalid} invalid passwords out of #{total_passwords}."
puts "There are #{num_valid} valid passwords."
