# Python Boolean = either True or False
day = "Friday"
temperature = 30
raining = True

if day == "Saturday" and temperature > 27 and not raining:
    print("Go swimming")
else:
    print("Learn Python")

# always use parenthesis when combining and + or
# OR NOT has more precedence than AND - AND has higher precedence than OR
if (day == "Saturday" and temperature > 27) or not raining:
    print("Go swimming")
else:
    print("Learn Python")