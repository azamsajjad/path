# available_exits = ["north", "south", "east", "west"]

# chosen_path = "" #equal to anything except whats in avl list

# # because empty string is not in the list, program enters the loop automatically, and stays in loop until condition is met
# while chosen_path not in available_exits:
#     chosen_path = input("Please choose an exit: ")
# print("aren't you glad you got out of there")

#same with BREAK option
available_exits = ["north", "south", "east", "west"]

chosen_path = "" 

while chosen_path not in available_exits:
    chosen_path = input("Please choose an exit: ")
    if chosen_path.casefold() == "quit":
        print("Game over")
        break
print("aren't you glad you got out of there")

