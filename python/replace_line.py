with open('test.txt', 'r') as f:
    data = f.readlines()
    print(data)


latest = data.index('# latest post\n')
data[latest + 2] = 'bar'

with open('test.txt', 'w') as f:
    f.writelines(data)
