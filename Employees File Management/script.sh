#!/bin/bash

FILE_PATH="employees.txt"

function check_integer {
    INT=${1}
    [ $(echo ${INT} | grep -c "^[0-9]*$") -ne 1 ] && echo 1 && return 1
    echo 0 && return 0
}

function check_name {
    NAME=${1}
    [ $(echo ${NAME} | grep -c "^[a-z,A-Z]*$") -ne 1 ] && echo 1 && return 1
    echo 0 && return 0
}

function id_exist {
    ID=${1}
    [ $(grep -c "^${ID}:" $FILE_PATH) -ne 0 ] && echo 1 && return 1
    echo 0 && return 0
}

function add_employee {
    CHECK_ID=$(check_integer $1)
    CHECK_NAME=$(check_name $2)
    CHECK_SALARY=$(check_integer $3)
    ID_EXIST=$(id_exist $1)
    if [ $# != 3 ]
    then
        echo "Invalid Parameters Number"
    elif [ ${CHECK_ID} -eq 1 ]
    then
        echo "Not a Valid ID"
    elif [ ${CHECK_NAME} -eq 1 ]
    then
        echo "Not a Valid Name"
    elif [ ${CHECK_SALARY} -eq 1 ]
    then
        echo "Not a Valid Salary"
    elif [ ${ID_EXIST} -eq 1 ]
    then
        echo "Employee with the Given ID Already Exist"
    else 
        printf "\n${1}:${2}:${3}" >> $FILE_PATH
    fi
}

function query_employee {
    ID=${1}
    CHECK_EXIST_ID=$(id_exist $ID)
    if [ ${CHECK_EXIST_ID} -eq 1 ]
    then
        EMP=$(cat $FILE_PATH | grep "^${ID}")
        print_employee $EMP
    else
        echo "Employee Not Exist"
    fi
}

function print_employee {
    echo "===================================="
    EMP=$1
    ID=$(echo $EMP | awk -F ':' '{print $1}')
    NAME=$(echo $EMP | awk -F ':' '{print $2}')
    SALARY=$(echo $EMP | awk -F ':' '{print $3}')
    echo "ID    Name    Salary"
    echo "${ID}    ${NAME}    ${SALARY}"
    echo "===================================="
}

function print_employees {
    while read EMP
    do 
        print_employee $EMP
    done < ${FILE_PATH}
}

function delete_employee {
    ID=$1
    CHECK_ID=$(check_integer ${ID})
    CHECK_EXIST_ID=$(id_exist ${ID})
    if [[ CHECK_ID -eq 0 && CHECK_EXIST_ID -eq 1 ]]
    then
        sed -i "/^${ID}:/d" ${FILE_PATH}
        echo "Employee is deleted successfully"
    else
        echo "Employee Is not Found"
    fi
}


function print_menu {
    echo "================================================"
    echo "------- Welcome to Employee Operations ---------"
    echo "1. Add Employee"
    echo "2. Query Employee"
    echo "3. Print Employees"
    echo "4. Delete Employee"
    echo "5. Exit"
    echo "Enter the Number of Operation to Apply: "
}

while [ 1 == 1 ]
do
    print_menu
    read OPERATION
    case ${OPERATION} in 
        1) echo "Enter ID: " && read ID
            echo "Enter Name: " && read NAME
            echo "Enter Salary: " && read SALARY
            add_employee ${ID} "${NAME}" ${SALARY}
        ;;
        2) echo "Enter ID: " && read ID
            query_employee ${ID}
        ;; 
        3) print_employees
        ;;
        4) echo "Enter ID: " && read ID
            delete_employee $ID
        ;;
        5) echo "Exiting....Bye........"
            exit 0
        ;;
        *) echo "ERROR: Not Available Command."
        ;;
    esac
done