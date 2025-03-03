# Bash Script for Basic Arithmetic Operations

## Description
This Bash script performs basic arithmetic operations (addition, subtraction, multiplication, and division) on two floating-point numbers provided as command-line arguments.

## Usage
Run the script with two floating-point numbers as parameters:

```bash
./script.sh <num1> <num2>
```

### Example:
```bash
./script.sh 5.2 3.1
```

### Output:
```
Sum = 8.3
Sub = 2.1
Mul = 16.12
Div = 1.67741935483870967741
```

## Prerequisites
Ensure that `bc` (a command-line calculator) is installed on your system. You can install it using:

- **Debian/Ubuntu**:
  ```bash
  sudo apt install bc
  ```
- **CentOS/RHEL**:
  ```bash
  sudo yum install bc
  ```
- **macOS (using Homebrew)**:
  ```bash
  brew install bc
  ```

## Error Handling
- The script requires exactly **two parameters**. If not provided, it will return:
  ```
  Insufficient parameters
  ```
- If the parameters are **not valid floating-point numbers**, it will return an error:
  ```
  1st parameter is not a valid number
  ```
  or
  ```
  2nd parameter is not a valid number
  ```

## Exit Codes
- `1`: Insufficient parameters.
- `2`: First parameter is not a valid number.
- `3`: Second parameter is not a valid number.
- `0`: Successful execution.