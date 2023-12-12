for i in range(1,13):
    print("No. {0} squared is {1} and cubed is {2}".format(i, i ** 2, i ** 3))

print()
for i in range(1,13):
    print("No. {0} squared is {1:3} and cubed is {2:4}".format(i, i ** 2, i ** 3))

print()
for i in range(1,13):
    print("No. {0} squared is {1:<3} and cubed is {2:^4}".format(i, i ** 2, i ** 3))

print()
print("Pi is approximately {}".format(22 / 7))
print("Pi is approximately {0}".format(22 / 7))
print("Pi is approximately {0:12}".format(22 / 7)) #default to print 15 decimals. 12 is field width
print("Pi is approximately {0:12f}".format(22 / 7)) #f is floating point decimals
print("Pi is approximately {0:12.50f}".format(22 / 7))
print("Pi is approximately {0:52.50f}".format(22 / 7))
print("Pi is approximately {0:62.50f}".format(22 / 7))
print("Pi is approximately {0:72.54f}".format(22 / 7))
print("Pi is approximately {0:<72.54f}".format(22 / 7)) # 51 decimals is limit, more are 000

print()
for i in range(1,13):
    print("No. {} squared is {} and cubed is {:>4}".format(i, i ** 2, i ** 3))




# fSTRING (could be used after python3.6, but it wont run on <3.6)
#formatted-strings 3.4 is very common, so be careful
name = "azam"
age = "34 years"
print(name + f" is {age} years old") 
#placing f lets us put curly braces with an int in string
print()
print("Pi is approximately {22 / 7:12.50f}")
print(f"Pi is approximately {22 / 7:12.50f}")

print()
pi = 22 /7
print("Pi is approximately {pi:12.50f}")
print(f"Pi is approximately {pi:12.50f}")