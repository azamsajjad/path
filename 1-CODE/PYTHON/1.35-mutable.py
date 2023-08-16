shopping_list = [ "milk",
                 "eggs",
                 "spam",
                 "bread",
                 "rice"
                 ]
another_list = shopping_list
print(id(shopping_list))
print(id(another_list))

shopping_list += ["cookies"]
print(shopping_list)
print(id(shopping_list))

#same id, b/c python can mutate lists, it dosnt have to create a new object after addition

# this program has total 1 list
print(another_list)

a = b = c = d = e = f = another_list
print(a)
print("Adding cream")
b.append("cream")
print(c)
print(d)

# still, this program has 1 list, but it has 8 aliases