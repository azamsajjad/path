a = 12 # 12 and 3 are also expressions, value 12 is assigned to variable a
b = 3 # a and b are not expressions, 

print(a + b)    # 15 - this code is called an expression
print(a - b)    # 9
print(a * b)    # 36
print(a / b)    # 4.0 float
print(a // b)   # 4 integer, rounded down towards minus infinity
print(a % b)    # 0 modula, the remainder after integer division

print()

for i in range(1, 4):
    print(i)

#for i in range(1, a / b):   # TypeError: 'float' object cannot be interpreted as an integer
  #  print(i)

for i in range(1, a // b): # this line has three expressions 1 2 3 , i is not expression, it is just bind to 1 2 3 
    print(i) 

#PYTHON is strongly typed, so you cant use float, where int must be used

print(a + b / 3 - 4 * 12)
print(a + (b/3) - (4*12))
#PEMDAS
#MD has equal precedense
#AD has equal precedense