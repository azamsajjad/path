available_exits = ["north", "south", "east", "west"]

chosen_path = ""

while chosen_path not in available_exits:
    chosen_path = input("Please choose an exit: ")
    if chosen_path.casefold() == "quit":
        print("Game over")
        break
else:
    print("aren't you glad you got out of there")
# now with else, 'quit' doesnot print last line, which is printed only when you guess it correctly