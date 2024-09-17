
# dataset = [1,3,10,4,5,8]
# for data in dataset do
#     puts data
# end

#function to calculate the mean of a set of numbers
def mean(data)
  sum = 0
  n = 0
  
  while n < data.length
    sum += data[n]
    n += 1
  end
  
  # Calculate the mean
  mean_value = sum / n.to_f 
  
  return mean_value
end




#function to return the largest value from a set of numbers
def maximum(dataset)
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
# def maximum(dataset)
# i=0
# a=0
# largest=0
# while (i!=dataset.length())
#    a=dataset[i]
#    puts "a: #{a}"
#    if(a>largest)
#      largest=a 
#    end
#    puts "largest (in loop): #{largest}"
#    i=i+1
# end
# puts "largest: #{largest}"
# end

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

# Function to convert Fahrenheit to Celsius
def fahrenheit_to_celsius(f)
  result = (f - 32) * 5.0 / 9.0
  format("%.2f", result)
end
