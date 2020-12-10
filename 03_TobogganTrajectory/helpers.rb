def retrieveSlopePoint(rows, current_row_index, current_column_index)
  return "" if rows.empty?

  revised_row_index = current_row_index

  if revised_row_index >= rows[0].length
    revised_row_index = revised_row_index % rows[0].length
  end

  rows[current_column_index][revised_row_index]
end

def count_num_trees(rows, row_slope, column_slope)
  current_row = 0
  current_column = 0
  tree_count = 0
  check_data = []

  while current_column < rows.length - 1
    current_row += row_slope
    current_column += column_slope
    next_slope_point = retrieveSlopePoint(rows, current_row, current_column)

    data = {
      row: current_row,
      column: current_column,
      isTree?: next_slope_point == "#"
    }
    check_data << data

    tree_count += 1 if data[:isTree?]
  end

  tree_count
end
