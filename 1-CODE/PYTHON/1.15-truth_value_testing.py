# constants defined to be false: None - False
# zero of any numeric type: 0,0.0,0j,Decimal(0),Fraction(0,1)
# empty sequences and collections: '',"",(),[],{},set(),range(0)
if 0:
    print("True")
else:
    print("False")

name = input("Please enter your name:")
#if name:
if name != "":
    print("Hello, {}".format(name))
else:
    print("Are you the man with no name")
