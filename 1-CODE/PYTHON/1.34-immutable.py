# Bool
result = True 
another_result = result
print(id(result))
print(id(another_result))

result = False 
print(id(result))


# String
result = "Correct" 
another_result = result
print(id(result))
print(id(another_result))

result += "ish"
print(id(result))

# id keeps changing after addition b/c python has to create a new object to store updated value, bools,strings,int,floats are immutable