from pydbg import *
import sys

def breakpoint_handler(dbg):
    print(dbg.dump_context())
    return DBG_CONTINUE

dbg = pydbg()
dbg.set_callback(EXCEPTION_BREAKPOINT, breakpoint_handler)
dbg.attach(int(sys.argv[1]))
dbg.bp_set(int(sys.argv[1], 16), "", 1)
dbg.debug_event_loop()
