
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
def generate_even_numbers(start_num, stop_num, file_path)
  even_numbers = (start_num..stop_num).select { |n| n.even? }
  File.open(file_path, 'w') do |file|
    even_numbers.each { |num| file.puts num }
  end
end

def fibonacci(limit,file_path)
  File.open(file_path,"w") do |file|
i=1
a=1
b=0
c=0
if(limit!=0)
  print "0 1"
  while(i!=limit)
      c=a+b #takes first two numbers and adds them
      print " #{c}"
      b=a #b goes up to a
      a=c #a goes up to c
      i=i+1
      file.write "#{c} "
      
  end
else
  puts "0"
end
 end
 end

