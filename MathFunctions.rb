
#this method calculates the exponent of a number.
def exponent(a, b)
  a ** b
end

# This method calculates the absolute value of a number.
def absolute(a)
  if a < 0
    -a
  else
    a
  end
end


# Generates square numbers in the given range and writes them to a file.
def generate_square_numbers(start_num, stop_num, file_path)
  square_numbers = (start_num..stop_num).map { |n| n**2 }
  File.open(file_path, 'w') do |file|
    square_numbers.each { |num| file.puts num }
  end
end

#Generates even numbers in the given range and writes them to a file.
def generate_even_numbers(start_num, end_num, file_path)
  evens = (start_num..end_num).select(&:even?)
  File.open(file_path, 'w') do |file|
    evens.each { |num| file.puts num }
  end
end

