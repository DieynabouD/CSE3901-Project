def exponent(a, b)
  a ** b
end


def absolute(a)
  if a < 0
    -a
  else
    a
  end
end


def generate_square_numbers(start_num, stop_num, file_path)
  square_numbers = (start_num..stop_num).map { |n| n**2 }
  File.open(file_path, 'w') do |file|
    square_numbers.each { |num| file.puts num }
  end
end


def generate_even_numbers(start_num, stop_num, file_path)
  even_numbers = (start_num..stop_num).select { |n| n.even? }
  File.open(file_path, 'w') do |file|
    even_numbers.each { |num| file.puts num }
  end
end
