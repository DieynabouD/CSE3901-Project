require 'tk'
require_relative 'MathFunctions'
require_relative 'Arithmetic'
require_relative 'BuiltMathFunctions'

# Create the main window
root = TkRoot.new { title "Advanced Calculator" }
root.minsize(600, 800)

# Create a text variable to hold the expression entered by the user
input_var = TkVariable.new

# Create a label to display the result
result_var = TkVariable.new("Result: ")

# Entry field where the user enters the expression
TkEntry.new(root, 'textvariable' => input_var, 'font' => 'Arial 24', 'justify' => 'right').pack('side' => 'top', 'fill' => 'x')

# Label to show the result
TkLabel.new(root, 'textvariable' => result_var, 'font' => 'Arial 24').pack('side' => 'top')

# Method to append to the expression when a button is pressed
def append_expression(input_var, value)
  input_var.value = input_var.value + value
end

# Method to evaluate the expression and handle errors
def evaluate_expression(input_var, result_var)
  begin
    result = eval(input_var.value) # Use eval to calculate the result
    result_var.value = "Result: #{result}"
  rescue ZeroDivisionError
    result_var.value = "Error: Division by zero"
  rescue SyntaxError
    result_var.value = "Error: Invalid Expression"
  rescue StandardError => e
    result_var.value = "Error: #{e.message}"
  end
end

# Method to clear the expression
def clear_expression(input_var, result_var)
  input_var.value = ""
  result_var.value = "Result: "
end

button_width = 7
button_height = 3

# Create the buttons for the calculator (numbers and operations)
button_frame = TkFrame.new(root).pack('side' => 'top', 'fill' => 'x')

# Buttons for digits 1-9, 0, and operators
buttons = [
  ['7', '8', '9', '/'],
  ['4', '5', '6', '*'],
  ['1', '2', '3', '-'],
  ['0', '.', '=', '+'],
  ['^', 'sin', 'cos', 'tan'],
  ['|x|', '%', 'C', 'Even'],
  ['Generate Squares']
]

buttons.each do |row|
  row_frame = TkFrame.new(button_frame).pack('side' => 'top', 'fill' => 'x')
  row.each do |char|
    TkButton.new(row_frame) do
      text char
      width button_width
      height button_height
      font 'Arial 24'

      case char
      when '='
        command { evaluate_expression(input_var, result_var) }
      when 'C'
        command { clear_expression(input_var, result_var) }
      when 'sin', 'cos', 'tan', '|x|', '^', '%', 'Square', 'Even'
        # For sin, cos, tan, and absolute
        command do
          case char
          when 'sin'
            result_var.value = "Result: #{sin(input_var.value.to_f)}"
          when 'cos'
            result_var.value = "Result: #{cos(input_var.value.to_f)}"
          when 'tan'
            result_var.value = "Result: #{tan(input_var.value.to_f)}"
          when '|x|'
            result_var.value = "Result: #{absolute(input_var.value.to_f)}"
          when '^'
            result_var.value = "Result: #{exponent(input_var.value.to_f, 2)}"
          when '%'
            result_var.value = "Result: #{modulo(input_var.value.to_i, 2)}"
          when 'Square'
            result_var.value = "Result: #{input_var.value.to_i**2}"
          when 'Even'
            result_var.value = "Result: #{input_var.value.to_i.even?}"
          end
        end
      when 'Generate Squares'
        command do
          # Prompt the user for the range and file path
          start_num = Tk.getSimpleDialog('Generate Squares', 'Enter the starting number:')
          end_num = Tk.getSimpleDialog('Generate Squares', 'Enter the ending number:')
          file_path = Tk.getSaveFile('Generate Squares', 'Save squares to file:', '', '*.txt')

          # Generate and save the square numbers
          generate_square_numbers(start_num.to_i, end_num.to_i, file_path)
          result_var.value = "Square numbers generated and saved to #{file_path}"
        end
      else
        command { append_expression(input_var, char) }
      end
    end.pack('side' => 'left')
  end
end

# Start the Tk main loop
Tk.mainloop
