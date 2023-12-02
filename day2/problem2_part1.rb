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
# 12 red cubes, 13 green cubes, and 14 blue cubes
# => [12,13,14]
reference = [12,13,14]
hash_games.each do |game_indice,draws|
  possible_game = []
  draws.each do |draw|
    possible_draw = draw.zip(reference).map { |combined| combined[0] <= combined[1]}
    possible_game.concat(possible_draw)
  end 
  if possible_game.all?
    somme += game_indice 
  end 
end 

puts somme