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

puts somme_part1("calibration_document")