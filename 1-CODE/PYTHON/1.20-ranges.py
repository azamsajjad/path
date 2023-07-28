for i in range(1, 20):
    print("i is now {}".format(i))
# printed 1 to 19, last char in range is not included.

for j in range(20):
    print("j is now {}".format(j))
# printed 1 to 19, last char in range is not included.

for k in range(0, -20, -2):
    print("k is now {}".format(k))
# printed 1 to 19, last char in range is not included.

# Write a program to print out all the numbers from 0 to 100 that are divisible by 7.
for i in range(0, 101, +7):
    print(i)