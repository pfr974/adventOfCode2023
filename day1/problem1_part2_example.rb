hash_conversion = {
  "one" => "1",
  "1" => "1",
  "two" => "2",
  "2" => "2",
  "three" => "3",
  "3" => "3",
  "four" => "4",
  "4" => "4",
  "five" => "5",
  "5" => "5",
  "six" => "6",
  "6" => "6",
  "seven" => "7",
  "7" => "7",
  "eight" => "8",
  "8" => "8",
  "nine" => "9",
  "9" => "9",
  "zero" => "0",
  "0" => "0",
}

# Used a hint from ruby australia slack: one1fiveight should become 18 not 15!
# If I want to keep the same approach (regex + hash), then I need to adapt the keys
# the digits are: one, two, three, four, five, six, seven, eight, nine
# they all share common characters at their end: e, o, e, none for four, e, none for six, n, t, e
# So we can rewrite a different hash that still work and give 281 
hash_conversion_bis = {
  "on" => "1",
  "1" => "1",
  "tw" => "2",
  "2" => "2",
  "thre" => "3",
  "3" => "3",
  "four" => "4",
  "4" => "4",
  "fiv" => "5",
  "5" => "5",
  "six" => "6",
  "6" => "6",
  "seve" => "7",
  "7" => "7",
  "eigh" => "8",
  "8" => "8",
  "nin" => "9",
  "9" => "9",
  "0" => "0",
}

# also, I realized that my regex was not working.
# /on|1|tw|2|thre|3|four|4|fiv|5|six|6|seve|7|eigh|8|nin|9|0/ does no work 
# for instance if the line is 1eightw, the number are not 1,8,2 but 1,8
# so we need to adapt it to /on(?=e)|1|tw(?=o)|2|thre(?=e)|3|four|4|fiv(?=e)|5|six|6|seve(?=n)|7|eigh(?=t)|8|nin(?=e)|9|0/
# This came up after some google search. I didn't know about the concept of lookaround: https://stackoverflow.com/questions/2973436/regex-lookahead-lookbehind-and-atomic-groups

calibration_doc = File.read("calibration_document_part2_example").split
somme = 0
regex = Regexp.union(hash_conversion_bis.keys)
regex_bis = /on(?=e)|1|tw(?=o)|2|thre(?=e)|3|four|4|fiv(?=e)|5|six|6|seve(?=n)|7|eigh(?=t)|8|nin(?=e)|9|0/
calibration_doc.each do |line|
  num = ""
  array_content = line.scan(regex)
  size = array_content.size 
  case size 
  when 0
    next 
  when 1
    num = (hash_conversion_bis[array_content[0]] + hash_conversion_bis[array_content[0]]).to_i
  else 
    num = (hash_conversion_bis[array_content[0]] + hash_conversion_bis[array_content[-1]]).to_i
  end
  somme += num
end
puts somme