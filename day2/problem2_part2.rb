input_doc = File.readlines("input").map(&:chomp)

def process_input(input_doc)
  convention = { 'red' => 0, 'green' => 1, 'blue' => 2 }

  draws = []
  input_doc.split(';').each do |draw|
    rgb = [0,0,0]
    draw.split(',').each do |cube|
      number_for_cube, color = cube.strip.split
      rgb[convention[color]] = number_for_cube.to_i
    end
    draws << rgb
  end
  draws
end 

game_id = 1
hash_games = {}

input_doc.each do |line|
  line_strp = line.sub(/^Game \d+: /, '')
  hash_games[game_id] = process_input(line_strp)
  game_id += 1
end

somme = 0
hash_games.each_value do |draws|
  red = []
  green = []
  blue = []
  draws.each do |draw|
    red << draw[0]
    green << draw[1]
    blue << draw[2]
  end
  somme += red.max*green.max*blue.max 
end 

puts somme