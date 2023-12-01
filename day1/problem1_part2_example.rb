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

calibration_doc = File.read("calibration_document_part2_example").split
somme = 0
regex = Regexp.union(hash_conversion.keys)
calibration_doc.each do |line|
  num = ""
  array_content = line.scan(regex)
  size = array_content.size 
  case size 
  when 0
    next 
  when 1
    num = (hash_conversion[array_content[0]] + hash_conversion[array_content[0]]).to_i
  else 
    num = (hash_conversion[array_content[0]] + hash_conversion[array_content[-1]]).to_i
  end
  somme += num
end
puts somme