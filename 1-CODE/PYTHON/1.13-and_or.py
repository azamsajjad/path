#make a program to see if someone is of working age
age = int(input("How old are you? "))

# if age >= 16 and age <= 65:
# simplify chained conditions
if 16 <= age <= 65:
    print("Have a good day at work!")

# same thing with an OR
if 16 < age or age > 65:
    print("Enjoy you free time")
else:
    print("Have a nice working day")

# AND, Python will stop checking as soon as it finds 1 condition that is False
# OR,  Python will stop as soon as it finds on is true
# if python find that age is less than 16, it stops, it doesnt bother with checking if age might be greater than 65 too