
#input_doc = File.readlines("input_example").map(&:chomp)
input_doc = File.readlines("input").map(&:chomp)

def part1(input_doc)
  somme_overall = 0
  input_doc.each do |line|
    #line_strp = line.sub(/^Card \d+: /, '') was not working because of some cards like
    # "Card   1: 13  5 40 15 21 61 74 55 32 56 | 21 57 74 56  7 84 37 47 75 66 68  8 55 22 53 61 40 13 15 41 32 46 95 65  5"
    # here the number of white space characters is larger than  was expecting
    line_strp = line.sub(/^Card\s+\d+:\s+/, '')
    pp line_strp
    elf_nb, winning_nb = line_strp.split('|')
    arr_elf_nb = elf_nb.split.map(&:to_i)
    arr_winning_nb = winning_nb.split.map(&:to_i)
    set_elf_nb = Set.new(arr_elf_nb)
    set_winning_nb = Set.new(arr_winning_nb)
    common_set = set_elf_nb & set_winning_nb
    if common_set.length > 0
      somme_overall += 2**(common_set.length - 1) 
    end 
  end
  somme_overall
end 

puts part1(input_doc)