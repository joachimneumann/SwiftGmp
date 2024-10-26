#!/usr/bin/env python3

import os
import subprocess

def evaluate_expression(expression, scale=100):
    """
    Evaluates a mathematical expression using the `bc` command line tool.
    Handles common expressions like basic arithmetic and abs/sqrt functions.
    Sets a default scale (precision) for floating-point operations.
    """
    
    expression = expression.replace("pi", "const_pi()")
    if expression == "e":
        expression = "const_e()"
    try:
        # Set scale for floating-point precision and evaluate expression in bc
        # The file bcrc adds several functions to bc
        command = f'export BC_LINE_LENGTH=0; echo "scale={scale}; {expression}" | bc -l bcrc'
        result = subprocess.run(
            command,
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, text=True
        )
        if result.returncode == 0:
#            print(result.stdout)
            return result.stdout.strip()  # Get the result from bc
        else:
            return "error"
    except Exception as e:
        return f"error: {str(e)}"

def should_ignore_line(line):
    """
    Returns True if the line is funny
    """
    return (line.startswith("displayWidth") or
            line.startswith("precision") or
            line.startswith("C") or
            line.startswith("M") or
            line.startswith("DISPLAY") or
            "±" in line or
            "%" in line or
            len(line) == 0)

def process_file(file_path):
    """
    Process a single text file, evaluate the expression before the '=' or '~=' sign using bc,
    and write the result to a corresponding .bc file.
    """
    print(f"{file_path}...")

    output_lines = []
    
    # Read the input file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    for line in lines:
        line = line.strip()
        line = line.replace("_", "")
        # Skip the lines that should be ignored
        if should_ignore_line(line):
            if line.startswith("//"):
                output_lines.append(line+"\n")
            elif len(line) > 0:
                output_lines.append("// "+line+"\n")
            continue

        if '~=' in line or '=' in line:
            # Determine if the line contains `=` or `~=`
            if '~=' in line:
                expression, result = line.split('~=', maxsplit=1)
                operator = '~='
            else:
                expression, result = line.split('=', maxsplit=1)
                operator = '~='

            expression = expression.strip()

            # Call bc to evaluate the expression
            evaluated_result = evaluate_expression(expression)

            # Create the new output line with the result from bc and retain the operator
            output_line = f"{expression} {operator} {evaluated_result}\n"
            output_lines.append(output_line)

    # Write to the corresponding .bc file
    output_file = file_path.replace('.txt', '.bc')
    with open(output_file, 'w') as output:
        output.writelines(output_lines)

    print(f"Processed {file_path} -> {output_file}")

def process_all_files_in_directory(directory):
    """
    Process all .txt files in the specified directory.
    """
    for filename in os.listdir(directory):
        if filename.endswith(".txt"):
            file_path = os.path.join(directory, filename)
            process_file(file_path)

if __name__ == "__main__":
    # Directory where the text files are located (current directory)
    directory = os.getcwd()
    
    # Process all files in the current directory
    process_all_files_in_directory(directory)
