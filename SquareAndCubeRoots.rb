# Method to get square roots.
def squareRoot(n)
  begin
    Math.sqrt(n)
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end

# Method to get cube roots.
def cubeRoot(n)
  begin
    cube_root_value = n ** (1.0 / 3.0)
    return cube_root_value
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end


