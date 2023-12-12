answer = 5
print("Guess the Number between 1 and 10")
guess = int(input())

# if guess < answer:
#     print("Please Guess Higher!")
# elif guess > answer:
#     print("Please Guess Lower!")
# else:
#     print("You got it Right!")




# if guess < answer:
#     print("Please Guess Higher!")
#     guess = int(input())
#     if guess == answer:
#         print("Now, You have guessed it right")
#     else:
#         print("You are a failure!")
# elif guess > answer:
#     print("Please Guess Lower!")
#     guess = int(input())
#     if guess == answer:
#         print("Now, You guessed it correctly")
#     else:
#         print("Give up!")
# else:
#     print("You got it Right!")


if guess != answer:
    if guess < answer:
        print("Please Guess Higher!")
    else:
        print("Please Guess Lower!")
    guess = int(input())
    if guess == answer:
        print("you guessed it correctly")
    else:
        print("give up!")
else:
    print("You Guessed it Correctly in First attempt")






if guess == answer:
    print("You got it Right in First attempt")
else:
    if guess < answer:
        print("Please Guess Higher!")
    else:
        print("Please Guess Lower!")
    guess = int(input())
    if guess == answer:
        print("you guessed it correctly")
    else:
        print("give up!")