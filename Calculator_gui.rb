require 'tk'
require_relative 'MathFunctions'
require_relative 'Arithmetic'
require_relative 'BuiltMathFunctions'
require_relative 'MathFunctions2'

# Create the main window
root = TkRoot.new { title "Advanced Calculator" }
root.minsize(600, 800)

# Create a text variable to hold the expression entered by the user
input_var = TkVariable.new

base_var = TkVariable.new("Base: ")

# Create a label to display the result
result_var = TkVariable.new("Result: ")

# Entry field where the user enters the expression
TkEntry.new(root, 'textvariable' => input_var, 'font' => 'Arial 20', 'justify' => 'right').pack('side' => 'top', 'fill' => 'x')

# Label to show the result
TkLabel.new(root, 'textvariable' => result_var, 'font' => 'Arial 20').pack('side' => 'top')

# Evaluate expressions including parentheses and operator precedence
def evaluate_expression(input_var, result_var)
  expression = input_var.value

  # Function to perform basic arithmetic
  def apply_operator(operator, a, b)
    case operator
    when '+'
      return addition(a, b)
    when '-'
      return subtraction(a, b)
    when '*'
      return multiply(a, b)
    when '/'
      return division(a, b)
    when '^'
      return exponent(a, b)
    when '%'
      return modulo(a, b)
    else
      raise "Unsupported operator #{operator}"
    end
  end

  # Function to handle parentheses by recursion
  def evaluate_parentheses(expression)
    while expression.include?('(')
      expression.sub!(/\([^()]*\)/) do |sub_expr|
        evaluate_basic(sub_expr[1..-2])  # Remove parentheses and evaluate
      end
    end
    evaluate_basic(expression)  # Evaluate the remaining expression
  end

  # Function to evaluate expressions without parentheses
  def evaluate_basic(expression)
    expression.gsub!(/(?<!\d)-/, ' -') # Add space before negative numbers
    numbers = expression.scan(/-?\d+\.?\d*/)  # Extract numbers including negative numbers
    operators = expression.scan(/[\+\-\*\/\^\%]/)  # Extract operators

    # Convert strings to floats
    numbers.map!(&:to_f)

    # Handle multiplication/division first (operator precedence)
    while operators.include?('*') || operators.include?('/')
      operators.each_with_index do |op, i|
        if op == '*' || op == '/'
          result = apply_operator(op, numbers[i], numbers[i + 1])
          numbers[i, 2] = result  # Replace the two numbers with the result
          operators.delete_at(i)  # Remove the operator
          break  # Reevaluate the loop since the array has changed
        end
      end
    end

    # Handle addition/subtraction
    result = numbers.shift  # Initialize the result with the first number
    operators.each_with_index do |op, i|
      result = apply_operator(op, result, numbers[i])
    end

    return result
  end

  begin
    # Start by evaluating parentheses, then the rest
    result = evaluate_parentheses(expression)
    result_var.value = "Result: #{result}"
  rescue StandardError => e
    result_var.value = "Error: Invalid expression"
  end
end

# Append to the expression when a button is pressed
def append_expression(input_var, value)
  input_var.value = input_var.value + value
end

# Clear the expression
def clear_expression(input_var, result_var)
  input_var.value = ""
  result_var.value = "Result: "
end

# Toggle the sign of the current number in the input
def toggle_sign(input_var)
  expression = input_var.value
  if expression.empty?
    return
  end
  
  # Check if the last entered part is a number and toggle its sign
  if expression[-1] =~ /\d/  # Check if the last character is a number
    # Find the last number in the expression and toggle its sign
    last_number_match = expression.match(/-?\d+\.?\d*$/)
    if last_number_match
      last_number = last_number_match[0]
      toggled_number = last_number.to_f * -1  # Toggle the sign
      input_var.value = expression.sub(/-?\d+\.?\d*$/, toggled_number.to_s)
    end
  end
end

button_width = 8
button_height = 4

# Create the buttons for the calculator (numbers and operations)
button_frame = TkFrame.new(root).pack('side' => 'top', 'fill' => 'x')

# Buttons for digits 1-9, 0, and operators
buttons = [
  ['7', '8', '9', '/','log(base,a)'],
  ['4', '5', '6', '*','Squares' ],
  ['1', '2', '3', '-'],
  ['0', '.', '=', '+', '('],
  ['^', 'sin', 'cos', 'tan', ')'],
  ['|x|', '%', 'C', 'Evens', '+/-'],  # Added the +/- button
  ['Squares', 'Binary', 'Octal', 'Hexadecimal'],
]

buttons.each do |row|
  row_frame = TkFrame.new(button_frame).pack('side' => 'top', 'fill' => 'x')
  row.each do |char|
    TkButton.new(row_frame) do
      text char
      width button_width
      height button_height
      font 'Arial 20'

      case char
      when '='
        command { evaluate_expression(input_var, result_var) }
      when 'C'
        command { clear_expression(input_var, result_var) }
      when 'sin', 'cos', 'tan', '|x|', 'Square', 'Even'
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
          end # Close case char inside the command
        end # Close command block
      when 'Squares'
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Squares"

          TkLabel.new(dialog) { text "Enter Starting Number" }.pack
          start_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => start_num_var).pack

          TkLabel.new(dialog) { text "Enter Ending Number" }.pack
          end_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => end_num_var).pack

          TkButton.new(dialog) do
            text "Save and Generate Squares"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save squares to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )

              if file_path
                generate_square_numbers(start_num_var.value.to_i, end_num_var.value.to_i, file_path)
                result_var.value = "Square numbers generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
        end
      when 'Evens'
        command do
          dialog = TkToplevel.new
          dialog.title = "Generate Even Numbers"

          TkLabel.new(dialog) { text "Enter Starting Number" }.pack
          start_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => start_num_var).pack

          TkLabel.new(dialog) { text "Enter Ending Number" }.pack
          end_num_var = TkVariable.new
          TkEntry.new(dialog, 'textvariable' => end_num_var).pack

          TkButton.new(dialog) do
            text "Save and Generate Evens"
            command do
              file_path = Tk.getSaveFile(
                'title' => 'Save evens to file',
                'defaultextension' => '.txt',
                'filetypes' => [['Text Files', '*.txt'], ['All Files', '*']]
              )

              if file_path
                generate_even_numbers(start_num_var.value.to_i, end_num_var.value.to_i, file_path)
                result_var.value = "Even numbers generated and saved to #{file_path}"
              end
              dialog.destroy
            end
          end.pack
        end
      when 'Binary'
        command do
          result_var.value = "Binary: #{to_binary(input_var.value.to_i)}"
        end
      when 'Octal'
        command do
          result_var.value = "Octal: #{to_octal(input_var.value.to_i)}"
        end
      when 'Hexadecimal'
        command do
          result_var.value = "Hexadecimal: #{to_hexadecimal(input_var.value.to_i)}"
        end
      else
        command { append_expression(input_var, char) }
      end
    end.pack('side' => 'left')
  end
end

# Start the Tk main loop
Tk.mainloop
