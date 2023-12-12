balance = 968.70
try:
    num = float(input('deposit '))
except ValueError:
    print('Must be a valid quantity.')

balance += num
print (f'Balance: {balance}')
