# print("Choose your option from the list below:")
# print("1-\tLearn Python")
# print("2-\tLearn Java")
# print("3-\tLearn Linux")
# print("4-\tLearn AWS")
# print("5-\tGo to Bed")
# print("0-\tExit")

# while True:
#     choice = input()
#     if choice == "0":
#         break
#     elif choice in "12345":
#         print("you have chosen {}".format(choice))
#     else:
#         print("Choose your option from the list below:")
#         print("1-\tLearn Python")
#         print("2-\tLearn Java")
#         print("3-\tLearn Linux")
#         print("4-\tLearn AWS")
#         print("5-\tGo to Bed")
#         print("0-\tExit")

# TO AVOID REPITITION

# choice = "-"
# while True:
#     if choice == "0":
#         break
#     elif choice in "12345":
#         print("you have chosen {}".format(choice))
#     else:
#         print("Choose your option from the list below:")
#         print("1-\tLearn Python")
#         print("2-\tLearn Java")
#         print("3-\tLearn Linux")
#         print("4-\tLearn AWS")
#         print("5-\tGo to Bed")
#         print("0-\tExit")
#     choice = input()


# Better Way
choice = "-"
while choice != "0":
    if choice in "12345":
        print("you have chosen {}".format(choice))
    else:
        print("Choose your option from the list below:")
        print("1-\tLearn Python")
        print("2-\tLearn Java")
        print("3-\tLearn Linux")
        print("4-\tLearn AWS")
        print("5-\tGo to Bed")
        print("0-\tExit")
    choice = input()
print("you exited")


for x in range(30):
    if x % 3 == 0 or x % 5 == 0:
        continue
    print(x)

#SAME OUTPUT HOW?

for x in range(30):
    if x % 3 != 0 and x % 5 != 0:
        print(x)

# This simple program counts how many periods (full stops) appear in the text.

# Which of the following blocks of code is equivalent to this one?

quote = """
# It's not pining. It's passed on. This parrot is no more. It has ceased to be.
# It's expired and gone to meet its maker.
# This is a late parrot.
# It's a stiff. Bereft of life, it rests in peace.
# If you hadn't nailed it to the perch, it would be pushing up the daisies.
# It's rung down the curtain and joined the choir invisible.
# THIS IS AN EX-PARROT.
# """
 
# period_count = 0
# for char in quote:
#     if char == '.':
#         period_count = period_count + 1

period_count = 0
for char in quote:
    if char == '.':
        period_count += 1