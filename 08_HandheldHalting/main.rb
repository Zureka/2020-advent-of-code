require "set"
require "pry"

ops = []

File.open("data.txt").each do |line|
  op_parts = line.split(" ").map { |p| p.strip }

  ops << {
    op: op_parts[0],
    arg: op_parts[1].to_i
  }
end

def run_program(ops)
  acc = 0
  pos = 0
  executed_instructions = Set.new
  started_infinite_loop = false
  completed_program = false

  while started_infinite_loop == false && completed_program == false
    started_infinite_loop = executed_instructions.include?(pos)
    completed_program = pos == ops.length
    break if started_infinite_loop || completed_program

    executed_instructions.add(pos)

    op = ops[pos]

    if op[:op] == "acc"
      acc += op[:arg]
      pos += 1
    elsif op[:op] == "jmp"
      pos += op[:arg]
    elsif op[:op] == "nop"
      pos += 1
    end
  end

  if started_infinite_loop
    puts "Found infinite loop at #{pos}"
    puts "Accumulator value: #{acc}"
    false
  elsif completed_program
    puts "Completed the program successfully!"
    puts "Accumulator value: #{acc}"
    true
  end
end

puts "\n--- Part 1 ---"
run_program(ops)

puts "\n--- Part 2 ---"

jmp_op_pos = ops.map.with_index { |op, i| i if op[:op] == "jmp" }.compact
nop_op_pos = ops.map.with_index { |op, i| i if op[:op] == "nop" }.compact

finished = false

jmp_op_pos.each do |pos|
  break if finished
  new_ops = ops.dup.map(&:dup)
  new_ops[pos][:op] = "nop"
  finished = run_program(new_ops)
end

nop_op_pos.each do |pos|
  break if finished
  new_ops = ops.dup.map(&:dup)
  new_ops[pos][:op] = "jmp"
  finished = run_program(new_ops)
end
