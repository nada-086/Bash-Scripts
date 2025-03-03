#!/bin/bash


[ ${#} -ne 2 ] && echo "Insufficient parameters" && exit 1
[ $(echo ${1} | grep -Ec "^[+-]?[0-9]*\.[0-9]+$") -ne 1 ] && echo "1st parameter is not a valid number" && exit 2
[ $(echo ${2} | grep -Ec "^[+-]?[0-9]*\.[0-9]+$") -ne 1 ] && echo "2st parameter is not a valid number" && exit 3

SUM=$(echo $1 + $2 | bc -l)
SUB=$(echo $1 - $2 | bc -l)
MUL=$(echo $1 \* $2 | bc -l)
DIV=$(echo $1 / $2 | bc -l)

echo "Sum = ${SUM}"
echo "Sub = ${SUB}"
echo "Mul = ${MUL}"
echo "Div = ${DIV}"

exit 0
