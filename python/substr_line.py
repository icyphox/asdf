import fileinput

for line in fileinput.FileInput('./test.txt', inplace=1):
    if "# all posts\n" in line:
        line = line.replace(line, line + "\nsome text here\n")
    print(line, end='')
