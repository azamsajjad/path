x = 23

x += 1
print(x) # 24
x -= 4
print(x) # 20
x *= 5
print(x) # 100
x //= 4
print(x) # 25
x /= 5
print(x) # 5.0 - conversion from int to float
x **= 2
print(x) # 25.0 - x is still a float
x %= 5
print(x) # 0.0 - 25 is exactly divisible by 5

greeting = "Good "
greeting += "morning "
print(greeting)

greeting *= 5
print(greeting)

#all binary operators can be used in augmented assignment

# augmented assignment in a loop
# Early computers could only perform addition. In order to multiply one number by another, they performed repeated addition.
# For example, 5 * 8 was performed by adding 5 eight times
# 5 + 5 + 5 + 5 + 5 + 5 + 5 + 5 = 40
# Write Python code to perform the repeated addition shown above.

# Use a for loop, and augmented assignment, to give answer the result of multiplying number by multiplier
# Paste your code into your IDE, and make sure it works with different values for number and multiplier.
# Note that this exercise checking system will only validate your code with the values 5 and 8, for number and multiplier.
number = 5
multiplier = 8
answer = 0
 
# add your loop after this comment
for i in range(multiplier):
    answer += number
 
print(answer)