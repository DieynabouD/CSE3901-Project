
# dataset = [1,3,10,4,5,8]
# for data in dataset do
#     puts data
# end


#function to calculate the mean (average) of a dataset
def mean(data)
  sum = data.reduce(0) { |acc, num| acc + num }  # Sum all elements
  n = data.length  # Get the number of elements
  return sum / n.to_f  # Calculate the mean
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
 def fibonacci(file_path,file)
  File.open(file_path,"w") do |file|
  
puts "Please give limit: "
limit=gets.chomp().to_i
i=1
a=1
b=0
c=0
if(limit!=0)
  print "1"
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

# Function to convert Fahrenheit to Celsius
def fahrenheit_to_celsius(f)
  result = (f - 32) * 5.0 / 9.0
  format("%.2f", result)
end
