#                   1
#         01234567890123
parrot = "Norwegian Blue"
print(parrot)

print(parrot[3])
print(parrot[4])
print(parrot[9])
print(parrot[3])
print(parrot[6])
print(parrot[8])
print()
print(parrot[-11]) # list character from end
print(parrot[-1])
print(parrot[-5])
print(parrot[-11])
print(parrot[-8])
print(parrot[-6])
print()
print(parrot[3 - 14])
print(parrot[4 - 14])
print(parrot[9 - 14])
print(parrot[3 - 14])
print(parrot[6 - 14])
print(parrot[8 - 14])
print()


# SLICING
#                     1
#           01234567890123
# parrot = "Norwegian Blue"
print(parrot[0:6]) #Norweg - upto_but_not_included
print(parrot[-14:-8]) #Norweg - same direction for not including
print(parrot[3:5]) #we
print(parrot[0:9]) #Norwegian
print(parrot[:9]) #Norwegian
print(parrot[10:14]) #Blue
print(parrot[10:]) #Blue

print(parrot[:10] + parrot[10:]) # Norwegian Blue
print(parrot[:]) # Norwegian Blue - USEFUL for LISTS

print(parrot[-4:-2]) #Bl
print(parrot[-4:12]) #Bl
print()
#STEPS in a Slice
#                     1
#           01234567890123
# parrot = "Norwegian Blue"
print(parrot[0:6:2]) #Norweg in steps of 2 = Nre
print(parrot[0:6:3]) #Norweg in steps of 3 = Nw


number = "9,345;300:321 333,330,346;301"
print(number[1::4])


#USE Case
number = "9,345;300:321 333,330,346;301"
seperated_list = number[1::4]
print(seperated_list)
#
values = "".join(char if char not in seperated_list else " " for char in number).split()
print([int(val) for val in values]) 
# see 1.19 for details