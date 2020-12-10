boarding_passes = []

File.open("data.txt").each do |line|
  line.strip!
  boarding_passes << {
    row_info: line[0..6],
    column_info: line[7..]
  }
end

def process_row_data(row)
  items = row.split("")
  possible_rows = (0..127).to_a

  items.each do |i|
    if i == "F"
      possible_rows = possible_rows[0..((possible_rows.length / 2) - 1)]
    elsif i == "B"
      possible_rows = possible_rows[((possible_rows.length / 2))..]
    end
  end

  possible_rows[0]
end

def process_column_data(col)
  items = col.split("")
  possible_columns = (0..7).to_a

  items.each do |i|
    if i == "L"
      possible_columns = possible_columns[0..((possible_columns.length / 2) - 1)]
    elsif i == "R"
      possible_columns = possible_columns[((possible_columns.length / 2))..]
    end
  end

  possible_columns[0]
end

puts "\n--- Part 1 ---"

seat_ids = boarding_passes.map { |pass|
  row = process_row_data(pass[:row_info])
  column = process_column_data(pass[:column_info])
  (row * 8) + column
}

puts "Highest seat ID value: #{seat_ids.max}"

puts "\n--- Part 2 ---"
max_seat_id = seat_ids.max
min_seat_id = seat_ids.min

possible_seat_ids = (min_seat_id..max_seat_id).to_a
remaining_seat_id = possible_seat_ids - seat_ids

puts missing_seat_id
