class BuiltMathFunctions
  #this method calculates sine of a number.
  def sin(n)
    begin
      Math.sin(n)
    rescue => e
      puts "Error calculating sine: #{e.message}"
    end
  end
  #this method calculates cosine of a number.
  def cos(n)
    begin
      Math.cos(n)
    rescue => e
      puts "Error calculating cosine: #{e.message}"
    end
  end
  #this method calculates tangent of a number.
  def tan(n)
    begin
      Math.tan(n)
    rescue => e
      puts "Error calculating tangent: #{e.message}"
    end
  end

  def log_with_base(base,a)
    begin
      Math.log(base,a)
    rescue => e
      puts "Error calculating logarithm: #{e.message}"
    end
  end
end