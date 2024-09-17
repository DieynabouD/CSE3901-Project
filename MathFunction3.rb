def is_prime(n)
    return false if n <= 1
    for i in 2..(n - 1)
      return false if n % i == 0
    end
    true
end
  
def minimum(data)
    min_value = data[0]
    for i in 1...data.length
      min_value = data[i] if data[i] < min_value
    end
    min_value
end  

def generate_odd_numbers(range_start, range_end, file_name)
    File.open(file_name, 'w') do |file|
      for i in range_start..range_end
        file.puts(i) if i % 2 != 0
      end
    end
end
  
def mode(data)
    frequency = {}
    for i in 0...data.length
      if frequency[data[i]]
        frequency[data[i]] += 1
      else
        frequency[data[i]] = 1
      end
    end
    
    max_frequency = 0
    mode_value = nil
    frequency.each do |key, value|
      if value > max_frequency
        max_frequency = value
        mode_value = key
      end
    end
    
    mode_value
end