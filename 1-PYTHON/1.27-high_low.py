# Opposite Guess Game
low = 1
high = 1000

print("Please guess a number between {} and {}".format (low, high))
input("Press Enter to Start!")

guesses = 1
while True:
    guess = low + (high - low) // 2