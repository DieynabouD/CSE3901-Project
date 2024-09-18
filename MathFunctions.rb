# This method calculates the sum of two numbers.
def sum(a, b)
  begin
    a + b
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# This method calculates the difference between two numbers.
def difference(a, b)
  begin
    a - b
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# This method calculates the product of two numbers.
def product(a, b)
  begin
    a * b
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# This method calculates the quotient of two numbers.
def quotient(a, b)
  begin
    a / b
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# This method calculates the exponent of a number.
def exponent(a, b)
  begin
    a ** b
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# This method calculates the absolute value of a number.
def absolute(a)
  begin
    if a < 0
      -a
    else
      a
    end
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# Generates square numbers in the given range and writes them to a file.
def generate_square_numbers(start_num, stop_num, file_path)
  begin
    square_numbers = (start_num..stop_num).map { |n| n**2 }
    File.open(file_path, 'w') do |file|
      square_numbers.each { |num| file.puts num }
    end
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

# Generates even numbers in the given range and writes them to a file.
def generate_even_numbers(start_num, end_num, file_path)
  begin
    evens = (start_num..end_num).select { |n| n.even? }
    File.open(file_path, 'w') do |file|
      file.puts evens.join(", ")
    end
  rescue => e
    puts "An error occurred: #{e.message}"
  end
end

