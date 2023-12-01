HASH_CONVERSION = {
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

def somme_part1(file)
  calibration_doc = File.read(file).split
  somme = 0
  calibration_doc.each do |line| 
    cleaned_line = line.delete('^0-9').chars
    num = ""
    size = cleaned_line.size
    case size 
      when 0
        next
      when 1
        num = (cleaned_line[0] + cleaned_line[0]).to_i
      else
        num = (cleaned_line[0] + cleaned_line[-1]).to_i
    end
    somme += num
  end
  somme 
end 

def somme_part2(file)
  calibration_doc = File.read(file).split
  somme = 0
  regex = Regexp.union(HASH_CONVERSION.keys)
  calibration_doc.each do |line|
    num = ""
    array_content = line.scan(regex)
    size = array_content.size 
    case size 
    when 0
      next 
    when 1
      num = (HASH_CONVERSION[array_content[0]] + HASH_CONVERSION[array_content[0]]).to_i
    else 
      num = (HASH_CONVERSION[array_content[0]] + HASH_CONVERSION[array_content[-1]]).to_i
    end
    somme += num
  end
  somme
end 


puts somme_part1("calibration_document")
puts somme_part2("calibration_document") #53998