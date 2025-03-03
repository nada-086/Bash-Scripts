# Employee Management Bash Script

## Description
This Bash script manages employee records by allowing users to add, query, list, and delete employees from a text file (`employees.txt`). It provides a simple command-line interface for interacting with employee data.

## Usage
Run the script by executing:

```bash
./script.sh
```

### Features
- **Add Employee**: Add a new employee with an ID, name, and salary.
- **Query Employee**: Search for an employee by ID.
- **Print Employees**: Display all stored employees.
- **Delete Employee**: Remove an employee by ID.
- **Exit**: Close the program.

## Prerequisites
Ensure that you have the necessary permissions to execute the script:

```bash
chmod +x script.sh
```

## Employee Data Format
The script stores employee data in `employees.txt` in the following format:

```
ID:Name:Salary
```

Example:
```
101:John:50000
102:Jane:55000
```

## Error Handling
- **Invalid input**: Checks if ID and salary are integers and name contains only letters.
- **Duplicate ID**: Prevents adding an employee with an existing ID.
- **Non-existent Employee**: Returns an error message if querying or deleting a missing employee.

## Exit Codes
- `0`: Successful execution.
- `1`: Invalid parameters or incorrect input format.