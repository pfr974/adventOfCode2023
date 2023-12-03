require 'matrix'

def read_matrix_from_input(input)
  matrix_rows = input.map { |line| line.chars }
  Matrix[*matrix_rows]
end

input_doc = File.readlines("input_example").map(&:chomp)
input_matrix = read_matrix_from_input(input_doc)
pp input_matrix