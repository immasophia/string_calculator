class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?
    delimiters, numbers = parse_numbers(numbers)
    numbers = split_numbers(numbers, delimiters).map(&:to_i)

    negatives = numbers.select{ |num| num < 0}

    if negatives.any?
      raise "negatives not allowed: #{negatives.join(', ')}"
    end
    numbers.select{ |num| num <= 1000}.sum
  end

  def self.parse_numbers(numbers)
    if numbers.start_with?("//")
      header, numbers  = numbers.split("\n", 2)
      delimiters = get_delimiters(header) 
    else
      delimiters = [",", "\n"]
    end
    return [delimiters, numbers]
  end

  def self.get_delimiters(header)
    if header.include?("[") && header.include?("]")
      delimiters = []
      delimiter_section = header[2..-1]
      current_delimiter = ""
      inside_brackets = false

      delimiter_section.each_char do |char|
        if char == '['
          inside_brackets = true
          current_delimiter = ""
        elsif char == ']'
          inside_brackets = false
          delimiters << current_delimiter
        elsif inside_brackets
          current_delimiter << char
        end
      end
      delimiters
    else
      [header[2..-1]]
    end
  end

  def self.split_numbers(numbers, delimiters)
    regex = Regexp.union(delimiters)
    numbers.split(regex)
  end
end