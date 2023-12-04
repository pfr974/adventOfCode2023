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

# simpler adjacent cells search with row and col values
def get_adjacent_cells_refactor(input_matrix, row, col)
  adjacent_cells = []
  nb_rows = input_matrix.row_count
  nb_cols = input_matrix.column_count
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
  cells
  #adjacent_cells
end

# identify numbers in the matrix
# with 467..114..
# we don't need to look for cells adjacent to 6 for instance. We only care about 467 as a whole.
# adjacent to an umber means adjacent to the start digit or last digit.
# For a number, we need to know where it is in the matrix: start position, end position
# no point of creating an hash with keys as the numbers
# I think an array where each element is an hash is more relevant 
def get_numbers(input_matrix)
  numbers = []
  nb_rows = input_matrix.row_count
  nb_cols = input_matrix.column_count

  input_matrix.each_with_index do |cell, row, col|
    next unless cell =~ /\d/ # https://ruby-doc.org/core-2.5.1/Regexp.html#class-Regexp-label-3D~+and+Regexp-23match
    next if col > 0 && input_matrix[row, col - 1] =~ /\d/ # proceed from left to right. For 467, 6 is not a number on its own but part of 467

    number = cell
    check_col = col + 1
    while check_col < nb_cols && input_matrix[row, check_col] =~ /\d/
      number += input_matrix[row, check_col]
      check_col += 1
    end
    numbers << { number: number, first_digit: [row, col], last_digit: [row, check_col - 1] }  
  end 
  numbers
end

def is_adjacent?(input_matrix, numbers)
  somme = 0
  regex_symbols = /[^a-zA-Z\d\.]/
  numbers.each do |num_hash|
    first_digit_row, first_digit_col = num_hash[:first_digit]
    last_digit_row, last_digit_col = num_hash[:last_digit]
    adjacent_cells_first_digit = get_adjacent_cells_refactor(input_matrix, first_digit_row, first_digit_col)
    adjacent_cells_last_digit = get_adjacent_cells_refactor(input_matrix, last_digit_row, last_digit_col)
    if adjacent_cells_first_digit.grep(regex_symbols).any? || adjacent_cells_last_digit.grep(regex_symbols).any?
      somme += num_hash[:number].to_i
    end
  end
  somme 
end 

#input_doc = File.readlines("input_example").map(&:chomp)
input_doc = File.readlines("input").map(&:chomp)
input_matrix = read_matrix_from_input(input_doc)
input_matrix_numbers = get_numbers(input_matrix)
puts is_adjacent?(input_matrix, input_matrix_numbers)
