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


def generate_square_numbers(start, stop, file_path)
  File.open(file_path, 'w') do |file|
    (start..stop).each do |num|
      file.puts(num ** 2)
    end
  end
end


def generate_even_numbers(start, stop, file_path)
  File.open(file_path, 'w') do |file|
    (start..stop).each do |num|
      file.puts(num) if num.even?
    end
  end
end

