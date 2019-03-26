import os
import sys

cmd = sys.argv[1]

print('Use Ctrl+D to quit')
while True:
    print(f'{sys.argv[1]}>> ', end='')
    try:
        line = input().strip()
    except Exception as e:
        print(e)
        sys.exit()

    run = f'{cmd} {line}'
    os.system(run)

