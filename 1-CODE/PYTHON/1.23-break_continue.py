# BREAK 
# Break
# Modify the code so that it stops printing when it reaches a number greater than zero that's exactly divisible by 11.

# That number should be the last value printed.

# Reminder: If a value, x, is divisible by 11 then x % 11 will be zero.
for i in range(0, 100, 7):
    print(i)
    if i > 0 and i % 11 == 0:
        break

#CONTINUE
# Continue
# Write a program to print out all the numbers from 0 to 20 that aren't divisible by either 3 or 5.
# Zero is considered divisible by everything (zero should not appear in the output).
for i in range(0, 21):
    if i % 3 == 0 or i % 5 == 0:
        continue
    print(i)