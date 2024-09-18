# This method performs addition of two numbers.
def addition(a, b)
  a + b
end

# This method performs subtraction of two numbers.
def subtraction(a, b)
  a - b
end

# This method performs division of two numbers.
# It raises an exception if the second number is zero.
def division(a, b)
  if b == 0
    "Error: Division by zero is not allowed"
  else
  a / b
  end
end

# This method performs multiplication of two numbers.
def multiply(a, b)
  a * b
end

# This method calculates the remainder of division between two numbers.
def modulo(a, b)
  a % b
end