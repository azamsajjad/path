# Opposite Guess Game
low = 1
high = 1000

print("Please guess a number between {} and {}".format(low, high))
input("Press Enter to Start!")
# we cant do while guess != answer because we dont know the value of answer
# we want computer to guess, nd user to input directions to guess lower or higher
# True is always True, so this loop will go on forever
guesses = 1
while low != high:
    #print("\tGuessing in the range of {} and {}".format(low, high))
    guess = low + (high - low) // 2
    high_low = input(
        "my guess is {}. Should I guess higher or lower? type h or l or c : ".format(
            guess
        )
    ).casefold()
# 4 possibilities for user
    if high_low == "h":
    # Guess higher. The low end of the range becomes 1 greater than the guess.
        low = guess + 1
    elif high_low == "l":
    # Guess lower. The high end of the range becomes 1 less than the guess.
        high = guess - 1
    elif high_low == "c":
        print("I got it in {} guesses!".format(guesses))
        break
    else:
        print("Please enter h, l or c")

    #guesses = guesses + 1
    guesses += 1
    #AUGMENTED ASSIGNMENT is efficient

#COPIEd
# we can make this program more impressive by not asking if number guessed is correct
# we know it must be, when low == high
# we can tell the player we have guessed their number 
else:
    print("You thought of the number {}".format(low))
    print("I got it in {} guesses".format(guesses))

# else in loop is basically 'completed' loop condition