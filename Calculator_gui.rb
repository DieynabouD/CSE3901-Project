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
TkEntry.new(root, 'textvariable' => input_var, 'font' => 'Arial 20', 'justify' => 'right').pack('side' => 'top', 'fill' => 'x')


TkLabel.new(root, 'textvariable' => result_var, 'font' => 'Arial 20').pack('side' => 'top')


# Method to evaluate basic arithmetic expressions with exponentiation and modulo
def evaluate_expression(input_var, result_var)
  expression = input_var.value
  
  # Split the expression into numbers and operators
  numbers = expression.scan(/\d+\.?\d*/).map(&:to_f)  # Extract numbers as floats
  operators = expression.scan(/[\+\-\*\/\^\%]/)  # Extract operators, including ^ and %

  # Initialize the result with the first number
  result = numbers.shift
  
  # Loop through operators and apply each operation to the result
  operators.each_with_index do |op, i|
    case op
    when '+'
      result = addition(result, numbers[i])
    when '-'
      result = subtraction(result, numbers[i])
    when '*'
      result = multiply(result, numbers[i])
    when '/'
      result = division(result, numbers[i])
    when '^'
      result = exponent(result, numbers[i])
    when '%'
      result = modulo(result, numbers[i])
    end
  end

  # Display the result
  result_var.value = "Result: #{result}"
end

# Method to append to the expression when a button is pressed
def append_expression(input_var, value)
  input_var.value = input_var.value + value
end


# Method to clear the expression
def clear_expression(input_var, result_var)
  input_var.value = ""
  result_var.value = "Result: "
end



button_width = 8
button_height = 4

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
  ['Squares']
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
          end.pack # Close TkButton
        end # Close command block for Generate Squares
      when 'Even'
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
          end.pack # Close TkButton
        end # Close command block for Generate Squares
      else
        command { append_expression(input_var, char) }
      end # Close case char block
    end.pack('side' => 'left') # Close TkButton
  end 
end

# File operations
TkLabel.new(root) { text "File Operations" }.pack

start_var = TkVariable.new
stop_var = TkVariable.new
file_path_var = TkVariable.new

TkLabel.new(root) { text "Start Number" }.pack
TkEntry.new(root, 'textvariable' => start_var).pack

TkLabel.new(root) { text "Stop Number" }.pack
TkEntry.new(root, 'textvariable' => stop_var).pack

TkLabel.new(root) { text "File Path" }.pack
TkEntry.new(root, 'textvariable' => file_path_var).pack

file_operations = {
  "Generate Square Numbers" => :generate_square_numbers,
  "Generate Even Numbers" => :generate_even_numbers
}

file_operations.each do |operation_name, operation|
  TkButton.new(root) do
    text operation_name
    command {
      send(operation, start_var.to_i, stop_var.to_i, file_path_var.value)
      result_var.value = "Generated #{operation_name}"
    }
  end.pack
end

# Start the Tk main loop
Tk.mainloop
