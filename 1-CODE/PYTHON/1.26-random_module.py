# same guessing game as 1.12
import random

highest = 1000
answer = random.randint(1, highest)
# print(answer) # TODO: Remove after testing 
guess = ""
print("Please guess the number between 1 and {}: ".format(highest))

while guess != answer:
    guess = int(input())
    if guess == 0:
        print("See You Next Time")
        break
    if guess == answer:
        print("Well done, You guessed it!")
        break
    else:
        if guess < answer:
            print("Please Guess Higher!")
        else:
            print("Please Guess Lower!")
        # guess = int(input())
        # if guess == answer:
        #     print("you guessed it correctly")
        # else:
        #     print("give up!")



# while guess != answer:
#     guess = int(input())
#     if guess == answer:
#         print("you guessed it correctly")
#         break

# BINARY SEARCH 500 guess 1 -> guess higher -> 750 guess 2 -> guess higher ->- 875 3
#with each guess, probability is halved