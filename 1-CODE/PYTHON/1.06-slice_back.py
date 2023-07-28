#          01234567890123456789012345
letters = "abcdefghijklmnopqrstuvwxyz"
print(letters[25:0:-1]) # a skipped when printing Backwords
# print(letters[25:-1:-1]) # error
print(letters[25::-1]) 
print(letters[::-1]) #PYTHON IDIOM FOR REVERSING THE ORDER

print(letters[16:13:-1])
print(letters[4::-1])

print(letters[25:17:-1])
# or
print(letters[:-9:-1]) #print last eight characters in reverse order - starts from -1
print(letters[:8:1]) #print first eight characters - starts from 0

#IDIOMS
print(letters[-4:]) # wxyz
print(letters[-1:]) # z
print(letters[:1]) # a
print(letters[0]) # a
