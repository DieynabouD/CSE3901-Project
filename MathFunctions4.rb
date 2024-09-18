
#function to calculate the mean (average) of a dataset
def mean(data)
  if data.length() == 0
    return "Error: Dataset is empty"
  end
  total = 0
  i = 0
  while i < data.length()
    total = total + data[i]
    i = i + 1
  end
  result = total / data.length.to_f
  return result
end


#maximum function to return the largest value from a set of numbers
def maximum(dataset)
  if dataset.length() == 0
    return "Error: Dataset is empty"
  end
  i = 0
  largest = dataset[0]
  while i < dataset.length()
    if dataset[i] > largest
      largest = dataset[i]
    end
    i = i + 1
  end
  largest
end



def fibonacci(limit,file_path)
  File.open(file_path,"w") do |file|
a=1
b=0
c=0
if(limit!=0)
  file.write "0 1 "
  while((a+b)<= limit)
      c=a+b #takes first two numbers and adds them
      b=a #b goes up to a
      a=c #a goes up to c
      file.write "#{c} "
      
  end
else
  file.write "0"
end
end
end

# Function to convert Fahrenheit to Celsius
def fahrenheit_to_celsius(f)
  result = (f - 32) * 5.0 / 9.0
  format("%.2f", result)
end
