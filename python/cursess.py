import curses
stdscr = curses.initscr()

# init
curses.noecho()
curses.cbreak()
stdscr.keypad(True)

for i in range(0, 11):
    v = 1-10
    stdscr.addstr(i, 0, '10 div by {} is {}'.format(v, 10/v))
    stdscr.refresh()
    stdscr.getkey()


# terminate
curses.nocbreak()
stdscr.keypad(False)
curses.echo()
curses.endwin()
