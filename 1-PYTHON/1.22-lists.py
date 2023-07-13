shopping_list = ["milk", "bread", "eggs", "yogurt", "mangoes", "bananas"]
for item in shopping_list:
    print("buy " + item)

print("-----------------------")

for item in shopping_list:
    if item != "mangoes":
        print("buy " + item)

print("-----------------------")

for item in shopping_list:
    if item == "mangoes":
        continue
    print("buy " + item)
# continue keyword doesnot let code to run below it, it goes back up to for loop

print("-----------------------")

for item in shopping_list:
    if item == "mangoes":
        break
    print("buy " + item)
# break the loop when you find the item you are looking for.

print("-----------------------")



shopping_list = ["milk", "bread", "eggs", "yogurt", "mangoes", "bananas"]

item_to_find = "mangoes"
found_at = None

for index in range(len(shopping_list)):
    if shopping_list[index] == item_to_find:
        found_at = index
        break
print("The item is found at position {}".format(found_at))

print("-----------------------")

shopping_list = ["milk", "bread", "eggs", "yogurt", "mangoes", "bananas"]

item_to_find = "apples"
found_at = None

for index in range(len(shopping_list)):
    if shopping_list[index] == item_to_find:
        found_at = index
        break
if found_at is not None:
    print("The item is found at position {}".format(found_at))
else:
    print("{} are not in the List".format(item_to_find))

print("-----------------------")

shopping_list = ["milk", "bread", "eggs", "yogurt", "mangoes", "bananas"]

item_to_find = "milk"
found_at = None

# Pro level solution - but not efficient, it can be improved
if item_to_find is not None:
    found_at = shopping_list.index(item_to_find)

if found_at is not None:
    print("The item is found at position {}".format(found_at))
else:
    print("{} is not in the List".format(item_to_find))






# BREAK 
# Break
# Modify the code so that it stops printing when it reaches a number greater than zero that's exactly divisible by 11.

# That number should be the last value printed.

# Reminder: If a value, x, is divisible by 11 then x % 11 will be zero.
# for i in range(0, 100, 7):
#     print(i)
#     if i > 0 and i % 11 == 0:
#         break