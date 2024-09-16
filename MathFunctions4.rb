
# dataset = [1,3,10,4,5,8]
# for data in dataset do
#     puts data
# end


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

<<<<<<< HEAD
# #function to convert fahrenheit to celsius
def fahrenheit_to_celsius()
    puts "Please enter your fahrenheit value: "
    f=gets.chomp.to_i
    a=(f-32)
    fraction=Rational(5,9)
    result=a*(fraction)
    puts "Celsius result: #{format("%.2f",result)}"
end
=======
# Function to convert Fahrenheit to Celsius
def fahrenheit_to_celsius(f)
  result = (f - 32) * 5.0 / 9.0
  format("%.2f", result)
end
>>>>>>> 66dbd2e1469bda669cdcaffa35854fc8a66a439e
