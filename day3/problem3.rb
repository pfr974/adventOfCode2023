require 'matrix' # https://ruby-doc.org/stdlib-2.5.1/libdoc/matrix/rdoc/Matrix.html

def read_matrix_from_input(input)
  matrix_rows = input.map { |line| line.chars }
  Matrix[*matrix_rows]
end

def get_adjacent_cells(input_matrix)
  adjacent_cells = []
  nb_rows = input_matrix.row_count
  nb_cols = input_matrix.column_count
  input_matrix.each_with_index do |cell, row, col|
    cells = []
    (-1..1).each do |offset_row| # allows to check left and right of a cell 
      (-1..1).each do |offset_col| # allows to check above and below a cell  
        next if offset_row == 0 && offset_col == 0 #allows to ignore the current cell we are looking at

        check_row = row + offset_row 
        check_col = col + offset_col

        if check_row.between?(0, nb_rows - 1) && check_col.between?(0, nb_cols - 1)
          cells << input_matrix[check_row, check_col]
        end
      end
    end
    adjacent_cells << cells
  end
  adjacent_cells
end


input_doc = File.readlines("input_example").map(&:chomp)
input_matrix = read_matrix_from_input(input_doc)
pp get_adjacent_cells(input_matrix)
