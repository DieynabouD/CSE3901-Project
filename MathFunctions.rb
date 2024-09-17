
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

#function to calculate the mean (average) of a dataset
def mean(dataset)
i=0
a=0
sum=0
puts "sum: #{sum}, a: #{a}, i: #{i}"
while (i!=dataset.length())
   a=dataset[i]
   puts "a: #{a}"
   sum=sum+a 
   puts "sum: #{sum}"
   i=i+1
end
result=sum/2
puts "#{result}"
end


#function to return the largest value from a set of numbers
def maximum(dataset)
i=0
a=0
largest=0
while (i!=dataset.length())
   a=dataset[i]
   puts "a: #{a}"
   if(a>largest)
     largest=a 
   end
   puts "largest (in loop): #{largest}"
   i=i+1
end
puts "largest: #{largest}"
end

 # #function to generate fibonacci numbers up to a given limit and save them to a file
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

# #function to convert fahrenheit to celsius
def fahrenheit_to_celsius()
    puts "Please enter your fahrenheit value: "
    f=gets.chomp.to_i
    a=(f-32)
    fraction=Rational(5,9)
    result=a*(fraction)
    puts "Celsius result: #{format("%.2f",result)}"
end