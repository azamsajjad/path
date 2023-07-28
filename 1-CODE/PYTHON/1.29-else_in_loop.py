# contrive
numbers = [1, 45, 31, 12, 60]

for number in numbers:
    if number % 8 == 0:
        #reject the list
        print("The numbers are unacceptable")
        break
else:
    print("Accepted")
# when our loop finds that numbers are not acceptable, our code breaks out of the loop