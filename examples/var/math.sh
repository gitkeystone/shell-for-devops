#! /usr/bin/env bash
var1=100
var2=50
var3=45
var4=$[${var1} * (${var2} - ${var3})]
echo The final result is: ${var4}

# Integer arithmetic.
echo $[${var1} / ${var3}]

# modulo
echo $[${var1} % ${var3}]

# Floating point arithmetic.
# variable=$(echo "options; expression" | bc)
var5=$(echo "scale=4; ${var1} / ${var3}" | bc)
echo The answer is ${var5}


# 多个浮点计算，请进行简化
var6=$(bc <<EOF
scale=4
a1 = ${var1} * ${var2}
b1 = ${var3} * ${var4}
a1 + b1
EOF
)

echo The final answer for this mess is ${var6}