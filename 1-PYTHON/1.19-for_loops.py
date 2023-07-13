# parrot = "Norwegian Blue"

# for character in parrot:
#     print(character)

#USE Case
# number = "9,345;300:321 333,330,346;301"
# seperated_list = number[1::4]
# print(seperated_list)
# #
# values = "".join(char if char not in seperated_list else " " for char in number).split()
# print([int(val) for val in values]) 

number = "9,345;300:321 333,330,346;301"
separators = ""

for character in number:
    if not character.isnumeric():
        separators = separators + character
     
# print(separators)
# debug to understand

number = input("Please enter series of numbers with separators:")
separators = ""

for character in number:
    if not character.isnumeric():
        separators = separators + character
     
print(separators)
values = "".join(char if char not in separators else " " for char in number).split()
print([int(val) for val in values])
print(sum([int(val) for val in values])) 
# CALCULATOR